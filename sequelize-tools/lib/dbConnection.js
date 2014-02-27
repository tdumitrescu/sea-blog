var Path      = require("path"),
    Sequelize = require("sequelize");

var DbConnection = (function() {
  function DbConnection(attrs) {
    var self = this;

    this.attrs   = attrs;
    this.testEnv = (this.attrs.testEnv != null) && this.attrs.testEnv;

    console.log("Initializing DB connection for " + this.attrs.dbName);

    this.sqlConnection = new Sequelize(
      this.attrs.dbName,
      this.attrs.user,
      this.attrs.password,
      this.attrs.options
    );

    this.sqlConnection.authenticate().complete(function(err) {
      if (err != null) {
        console.log("Unable to connect to database: " + err);
      } else {
        console.log("Connected to " + self.attrs.dbName);
      }
    });
  }

  DbConnection.defaultConnection = function() {
    var configPath, dbEnv, envConfig;

    if (this._defaultConnection) {
      return this._defaultConnection;
    }

    dbEnv      = this.chooseEnv();
    configPath = require.resolve(Path.resolve("server/config/database"));
    envConfig  = (require(configPath)).DBConfig[dbEnv];

    if (!envConfig) {
      throw "No database configuration defined for environment '" + dbEnv + "'.";
    }
    if (dbEnv === "test") {
      envConfig.testEnv = true;
    }

    this._defaultConnection = new DbConnection(envConfig);
    return this._defaultConnection;
  };

  DbConnection.chooseEnv = function() {
    if (process.env.npm_lifecycle_event === "test") {
      process.env.NODE_ENV = "test";
    }
    if (process.env.NODE_ENV) {
      return process.env.NODE_ENV;
    }

    console.log("NODE_ENV not defined. Defaulting to 'development'.");
    return "development";
  };

  DbConnection.init = function(success) {
    this.defaultConnection().sync().complete(function(err) {
      if (err != null) {
        console.log("Unable to sync DB: " + err);
      } else {
        success();
      }
    });
  };

  DbConnection.sequelize = function() {
    return this.defaultConnection().sqlConnection;
  };

  DbConnection.prototype.sync = function() {
    return this.sqlConnection.sync({force: this.testEnv});
  };

  return DbConnection;
})();

module.exports = DbConnection;
