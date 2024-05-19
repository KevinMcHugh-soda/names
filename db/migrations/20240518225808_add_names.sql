-- migrate:up
CREATE TABLE names (
    "id" BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name" text,
    "is_female" boolean
);

CREATE TABLE popularity (
    "id" BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name_id" BIGINT NOT NULL REFERENCES "names" ("id"),
    "nationality" text,
    "value" int
);

CREATE TABLE decisions (
    "id" BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name_id" BIGINT NOT NULL REFERENCES "names" ("id"),
    "approve" BOOLEAN NOT NULL,
    "user" TEXT,
    UNIQUE ("name_id", "user")
);


-- migrate:down
DROP TABLE decisions;
DROP TABLE popularity;
DROP TABLE names;
