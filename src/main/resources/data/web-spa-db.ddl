CREATE TABLE PUBLIC.ACTIONS_AVAILABLE (
	AAID INTEGER NOT NULL,
	PPID INTEGER,
	NUMBER INTEGER NOT NULL,
	COMMAND VARCHAR(255) NOT NULL,
	LAST_EXECUTED TIMESTAMP,
	RUN_SUCCESS BOOLEAN,
	IP_ADDR VARCHAR(25),
	PRIMARY KEY (AAID)
);

CREATE TABLE PUBLIC.ACTIONS_RECEIVED (
	ARID INTEGER NOT NULL,
	IP_ADDR VARCHAR(25),
	RECEIVED TIMESTAMP NOT NULL,
	KNOCK VARCHAR(100) NOT NULL,
	AAID INTEGER,
	PRIMARY KEY (ARID)
);

CREATE TABLE PUBLIC.PASSPHRASES (
	PPID INTEGER NOT NULL,
	PASSPHRASE VARCHAR(255) NOT NULL,
	CREATED TIMESTAMP NOT NULL,
	MODIFIED TIMESTAMP NOT NULL,
	PRIMARY KEY (PPID)
);

CREATE TABLE PUBLIC.USERS (
	USID INTEGER NOT NULL,
	PPID INTEGER,
	FULLNAME VARCHAR(255),
	EMAIL VARCHAR(255),
	PHONE VARCHAR(25),
	CREATED TIMESTAMP NOT NULL,
	MODIFIED TIMESTAMP NOT NULL,
	PRIMARY KEY (USID)
);

ALTER TABLE PUBLIC.ACTIONS_AVAILABLE
	ADD FOREIGN KEY (PPID) 
	REFERENCES PASSPHRASES (PPID);



ALTER TABLE PUBLIC.ACTIONS_RECEIVED
	ADD FOREIGN KEY (AAID) 
	REFERENCES ACTIONS_AVAILABLE (AAID);



ALTER TABLE PUBLIC.USERS
	ADD FOREIGN KEY (PPID) 
	REFERENCES PASSPHRASES (PPID);



CREATE UNIQUE INDEX PUBLIC.SYS_IDX_46 ON PUBLIC.PASSPHRASES (PPID);

CREATE UNIQUE INDEX PUBLIC.SYS_IDX_49 ON PUBLIC.USERS (USID);

CREATE INDEX PUBLIC.SYS_IDX_51 ON PUBLIC.USERS (PPID);

CREATE UNIQUE INDEX PUBLIC.SYS_IDX_54 ON PUBLIC.ACTIONS_AVAILABLE (AAID);

CREATE INDEX PUBLIC.SYS_IDX_56 ON PUBLIC.ACTIONS_AVAILABLE (PPID);

CREATE UNIQUE INDEX PUBLIC.SYS_IDX_59 ON PUBLIC.ACTIONS_RECEIVED (ARID);

CREATE INDEX PUBLIC.SYS_IDX_61 ON PUBLIC.ACTIONS_RECEIVED (AAID);
