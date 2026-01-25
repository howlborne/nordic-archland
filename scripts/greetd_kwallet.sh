#!/usr/bin/env bash

sed -i "/auth\s\+include\s\+system-local-login/a auth       optional     pam_kwallet5.so" /etc/pam.d/greetd

sed -i "/session\s\+include\s\+system-local-login/a session    optional     pam_kwallet5.so auto_start force_run" /etc/pam.d/greetd
