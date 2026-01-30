<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=' . (getenv('DB_HOST') ?: 'localhost') . ';dbname=' . (getenv('DB_NAME') ?: 'DB_NAME'),
    'username' => getenv('DB_USER') ?: 'DB_USER',
    'password' => getenv('DB_PASSWORD') ?: 'DB_PASSWORD',
    'charset' => 'utf8',
    'tablePrefix' => '',
    'enableSchemaCache' => true,
];
