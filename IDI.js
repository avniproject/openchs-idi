const {postAllRules} = require("rules-config/infra");
const HttpClient = require('./httpClient');

class IDI {
    constructor() {
    }

    req(asUser, method, api) {
        return {
            asUser,
            run: (files, user) => this.requestMany(method, api, files, user)
        }
    }

    postRules(asUser) {
        return {
            asUser,
            run: (files, user) => HttpClient.getToken(user).then(token=> postAllRules(user, files[0], this.serverUrl, token))
        }
    }

    configure(grunt, configuration) {
        const req = this.req.bind(this);
        this.grunt = grunt;
        this.conf = configuration;
        HttpClient.load(this.conf.secrets, this.env);
        grunt.initConfig({
            deploy: {
                adminUsers: req('chs-admin', 'POST', 'users'),
                forms: req('org-admin', 'POST', 'forms'),
                formDeletions: req('org-admin', 'DELETE', 'forms'),
                formAdditions: req('org-admin', 'PATCH', 'forms'),
                formMappings: req('org-admin', 'POST', 'formMappings'),
                catchments: req('org-admin', 'POST', 'catchments'),
                checklistDetails: req('org-admin', 'POST', 'checklistDetail'),
                concepts: req('org-admin', 'POST', 'concepts'),
                locations: req('org-admin', 'POST', 'locations'),
                programs: req('org-admin', 'POST', 'programs'),
                encounterTypes: req('org-admin', 'POST', 'encounterTypes'),
                operationalEncounterTypes: req('org-admin', 'POST', 'operationalEncounterTypes'),
                operationalPrograms: req('org-admin', 'POST', 'operationalPrograms'),
                operationalSubjectTypes: req('org-admin', 'POST', 'operationalSubjectTypes'),
                users: req('org-admin', 'POST', 'users'),
                rules: this.postRules('org-admin'),
                organisationSql: {
                    asUser: 'org-admin', run: () => {
                    }
                },
                all: '',
            }
        });

        ['dev', 'staging', 'prod', 'uat'].forEach((env) => {
            grunt.registerTask(env, `Use env: ${env.toUpperCase()}`, () => grunt.option('target', env));
        });

        const idi = this;
        grunt.registerMultiTask('deploy', "Everything happens here.", function () {
            const done = this.async();
            if (this.target === 'all') {
                idi.logger(`Target Environment: ${idi.env}`);
                idi.deployAll().then(done, done);
            } else {
                idi.logger(`Target Environment: ${idi.env}`);
                idi.deploy(this.target).then(done, done);
            }
        });

        grunt.registerTask('default', 'grunt --help\n', grunt.help.display);
    }

    get env() {
        return this.grunt.option('target') || 'dev';
    }

    get serverUrl() {
        return this.conf.secrets[this.env] || 'http://localhost:8021';
    }

    url(endpoint) {
        return this.serverUrl + '/' + endpoint;
    }

    get logger() {
        return this.grunt.log.writeln;
    }

    requestMany(method, endpoint, filepaths, user) {
        const logger = this.logger;
        logger(`++ START: ${endpoint}`);
        const url = this.url(endpoint);
        const requestSeq = filepaths.reduce((requestSeq, filepath) => {
            const body = this.grunt.file.read(filepath);
            return requestSeq
                .then(_ => HttpClient.req(method, url, body, user))
                .then(_ => logger(`-- DONE: ${filepath}`))
                .catch(e => {
                    logger(`-- FAIL: ${filepath}`);
                    throw e; // do not continue on any failure
                });
        }, Promise.resolve());

        return requestSeq
            .then((res) => {
                res.data && logger(res.data);
            })
            .catch((err) => {
                logger(err);
                const errMessage = err.response && err.response.data && (err.response.data.message?
                    err.response.data.message: err.response.data);
                logger(errMessage);
                logger(`++ FAIL: Failed`);
                throw err;
            });
    }

    deploy(taskName) {
        const taskDef = this.grunt.config.get(`deploy.${taskName}`);
        const fileInfo = this.conf.files[taskName];
        const files = this.grunt.util.kindOf(fileInfo) === 'object' ? fileInfo[this.env] : fileInfo;
        const user = this.conf[taskDef.asUser];
        return taskDef.run(files, user);
    }

    deployAll() {
        return IDI.allTasks.reduce((taskSeq, taskName) => {
            return taskSeq
                .then(_ => this.deploy(taskName))
                .then(_ => this.logger(`++`))
                .catch(e => {
                    this.logger(`++`);
                    throw e; // do not continue on any failure
                });
        }, Promise.resolve());
    }

    static configure(configuration) {
        const idi = new IDI();
        return function (grunt) {
            idi.configure(grunt, configuration);
        }
    }

    static get allTasks() {
        return [
            'adminUsers',
            'locations',
            'catchments',
            'users',
            'concepts',
            'encounterTypes',
            'programs',
            'operationalEncounterTypes',
            'operationalPrograms',
            'forms',
            'formDeletions',
            'formAdditions',
            'formMappings',
            'checklistDetails',
            'rules'
        ]
    }
}

module.exports = IDI;