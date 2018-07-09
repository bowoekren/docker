#!/bin/sh
yarn install --ignore-engines

bundle check || bundle install

rails s
