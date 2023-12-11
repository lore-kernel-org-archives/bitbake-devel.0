Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA55CC4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:59:32 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.5842.1702292369628846247
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Dec 2023 02:59:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CIu58Gga;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8188240006;
	Mon, 11 Dec 2023 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702292367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2VLoTWp7GqvJEJL+sD5GrVhKVkULev3flyuknINjA8=;
	b=CIu58GgawhQ+mRB2PNEa6Hjz0ZO5ouRLL7YEQbZTvFxv6UKG54hVjKesNz+GhIfM3d9WLM
	0C6JPafk/w07kqjAVu+oiEd/saDaHhbDvaBqQcNWG6HzO17aWqDtV1B7+A4wdQaJ6vKYMz
	q2ex7gF5Nd0hWtYKaVnknTf6dv0Qmbg+ZI+VQeJXvKbDkkmEyJSsmsBMcbpS9K2SuU8anK
	yiD9VsJeCyi1lTkE+OPQSRqYydBOjHTAKF5YVQssih2aTeHSqeC+BDUVqYD7ru/qg73Ydy
	xo+0XeyUfrkcyBKnSfAUeq6BC+Le3VGTotlPglUTXZ4osi8CQmySXzS2ryaSUg==
Date: Mon, 11 Dec 2023 11:59:26 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [toaster][PATCHv5 1/1] toaster: Added new
 feature to import eventlogs from command line into toaster using replay
 functionality
Message-ID: <2023121110592609a251b0@mail.local>
References: <20231211030706.108629-1-marlon.rodriguez-garcia@savoirfairelinux.com>
 <20231211030706.108629-2-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211030706.108629-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 10:59:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15646

Hello,

This doesn't applied on master, can you rebase?

On 10/12/2023 22:07:06-0500, Marlon Rodriguez Garcia wrote:
> Added a new button on the base template to access a new template.
> Added a model register the information on the builds and generate access links
> Added a form to include the option to load specific files
> Added jquery and ajax functions to block screen and redirect to build page when import eventlogs is trigger
> Added a new button on landing page linked to import build page, and set min-height of buttons in landing page for uniformity
> Removed test assertion to check command line build in content, because new button contains text
> Updated toaster_eventreplay to use library
> Fix test in test_layerdetails_page
> 
> This feature uses the value from the variable BB_DEFAULT_EVENTLOG to read the files created by bitbake
> Exclude listing of files that don't contain the allvariables definitions used to replay builds
> This part of the feature should be revisited. Over a long period of time, the BB_DEFAULT_EVENTLOG
> will exponentially increase the size of the log file and cause bottlenecks when importing.
> 
> Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
> ---
>  bin/toaster-eventreplay                       |  80 ++-----
>  lib/bb/ui/eventreplay.py                      |  86 ++++++++
>  lib/bb/ui/toasterui.py                        |   2 +-
>  .../orm/migrations/0021_eventlogsimports.py   |  22 ++
>  lib/toaster/orm/models.py                     |   9 +
>  .../tests/browser/test_landing_page.py        |   2 -
>  .../tests/browser/test_layerdetails_page.py   |   9 +-
>  lib/toaster/toastergui/forms.py               |  14 ++
>  lib/toaster/toastergui/static/css/default.css |  28 +++
>  lib/toaster/toastergui/templates/base.html    |   3 +-
>  .../templates/command_line_builds.html        | 198 ++++++++++++++++++
>  lib/toaster/toastergui/templates/landing.html |  10 +-
>  lib/toaster/toastergui/urls.py                |   1 +
>  lib/toaster/toastergui/views.py               | 173 ++++++++++++++-
>  14 files changed, 559 insertions(+), 78 deletions(-)
>  create mode 100644 lib/bb/ui/eventreplay.py
>  create mode 100644 lib/toaster/orm/migrations/0021_eventlogsimports.py
>  create mode 100644 lib/toaster/toastergui/forms.py
>  create mode 100644 lib/toaster/toastergui/templates/command_line_builds.html
> 
> diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
> index 404b61f5..74a31932 100755
> --- a/bin/toaster-eventreplay
> +++ b/bin/toaster-eventreplay
> @@ -30,79 +30,23 @@ sys.path.insert(0, join(dirname(dirname(abspath(__file__))), 'lib'))
>  
>  import bb.cooker
>  from bb.ui import toasterui
> -
> -class EventPlayer:
> -    """Emulate a connection to a bitbake server."""
> -
> -    def __init__(self, eventfile, variables):
> -        self.eventfile = eventfile
> -        self.variables = variables
> -        self.eventmask = []
> -
> -    def waitEvent(self, _timeout):
> -        """Read event from the file."""
> -        line = self.eventfile.readline().strip()
> -        if not line:
> -            return
> -        try:
> -            event_str = json.loads(line)['vars'].encode('utf-8')
> -            event = pickle.loads(codecs.decode(event_str, 'base64'))
> -            event_name = "%s.%s" % (event.__module__, event.__class__.__name__)
> -            if event_name not in self.eventmask:
> -                return
> -            return event
> -        except ValueError as err:
> -            print("Failed loading ", line)
> -            raise err
> -
> -    def runCommand(self, command_line):
> -        """Emulate running a command on the server."""
> -        name = command_line[0]
> -
> -        if name == "getVariable":
> -            var_name = command_line[1]
> -            variable = self.variables.get(var_name)
> -            if variable:
> -                return variable['v'], None
> -            return None, "Missing variable %s" % var_name
> -
> -        elif name == "getAllKeysWithFlags":
> -            dump = {}
> -            flaglist = command_line[1]
> -            for key, val in self.variables.items():
> -                try:
> -                    if not key.startswith("__"):
> -                        dump[key] = {
> -                            'v': val['v'],
> -                            'history' : val['history'],
> -                        }
> -                        for flag in flaglist:
> -                            dump[key][flag] = val[flag]
> -                except Exception as err:
> -                    print(err)
> -            return (dump, None)
> -
> -        elif name == 'setEventMask':
> -            self.eventmask = command_line[-1]
> -            return True, None
> -
> -        else:
> -            raise Exception("Command %s not implemented" % command_line[0])
> -
> -    def getEventHandle(self):
> -        """
> -        This method is called by toasterui.
> -        The return value is passed to self.runCommand but not used there.
> -        """
> -        pass
> +from bb.ui import eventreplay
>  
>  def main(argv):
>      with open(argv[-1]) as eventfile:
>          # load variables from the first line
> -        variables = json.loads(eventfile.readline().strip())['allvariables']
> -
> +        variables = None
> +        while line := eventfile.readline().strip():
> +            try:
> +                variables = json.loads(line)['allvariables']
> +                break
> +            except (KeyError, json.JSONDecodeError):
> +                continue
> +        if not variables:
> +            sys.exit("Cannot find allvariables entry in event log file %s" % argv[-1])
> +        eventfile.seek(0)
>          params = namedtuple('ConfigParams', ['observe_only'])(True)
> -        player = EventPlayer(eventfile, variables)
> +        player = eventreplay.EventPlayer(eventfile, variables)
>  
>          return toasterui.main(player, player, params)
>  
> diff --git a/lib/bb/ui/eventreplay.py b/lib/bb/ui/eventreplay.py
> new file mode 100644
> index 00000000..d62ecbfa
> --- /dev/null
> +++ b/lib/bb/ui/eventreplay.py
> @@ -0,0 +1,86 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# This file re-uses code spread throughout other Bitbake source files.
> +# As such, all other copyrights belong to their own right holders.
> +#
> +
> +
> +import os
> +import sys
> +import json
> +import pickle
> +import codecs
> +
> +
> +class EventPlayer:
> +    """Emulate a connection to a bitbake server."""
> +
> +    def __init__(self, eventfile, variables):
> +        self.eventfile = eventfile
> +        self.variables = variables
> +        self.eventmask = []
> +
> +    def waitEvent(self, _timeout):
> +        """Read event from the file."""
> +        line = self.eventfile.readline().strip()
> +        if not line:
> +            return
> +        try:
> +            decodedline = json.loads(line)
> +            if 'allvariables' in decodedline:
> +                self.variables = decodedline['allvariables']
> +                return
> +            if not 'vars' in decodedline:
> +                raise ValueError
> +            event_str = decodedline['vars'].encode('utf-8')
> +            event = pickle.loads(codecs.decode(event_str, 'base64'))
> +            event_name = "%s.%s" % (event.__module__, event.__class__.__name__)
> +            if event_name not in self.eventmask:
> +                return
> +            return event
> +        except ValueError as err:
> +            print("Failed loading ", line)
> +            raise err
> +
> +    def runCommand(self, command_line):
> +        """Emulate running a command on the server."""
> +        name = command_line[0]
> +
> +        if name == "getVariable":
> +            var_name = command_line[1]
> +            variable = self.variables.get(var_name)
> +            if variable:
> +                return variable['v'], None
> +            return None, "Missing variable %s" % var_name
> +
> +        elif name == "getAllKeysWithFlags":
> +            dump = {}
> +            flaglist = command_line[1]
> +            for key, val in self.variables.items():
> +                try:
> +                    if not key.startswith("__"):
> +                        dump[key] = {
> +                            'v': val['v'],
> +                            'history' : val['history'],
> +                        }
> +                        for flag in flaglist:
> +                            dump[key][flag] = val[flag]
> +                except Exception as err:
> +                    print(err)
> +            return (dump, None)
> +
> +        elif name == 'setEventMask':
> +            self.eventmask = command_line[-1]
> +            return True, None
> +
> +        else:
> +            raise Exception("Command %s not implemented" % command_line[0])
> +
> +    def getEventHandle(self):
> +        """
> +        This method is called by toasterui.
> +        The return value is passed to self.runCommand but not used there.
> +        """
> +        pass
> diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
> index ec5bd4f1..6bd21f18 100644
> --- a/lib/bb/ui/toasterui.py
> +++ b/lib/bb/ui/toasterui.py
> @@ -385,7 +385,7 @@ def main(server, eventHandler, params):
>                      main.shutdown = 1
>  
>                  logger.info("ToasterUI build done, brbe: %s", brbe)
> -                continue
> +                break
>  
>              if isinstance(event, (bb.command.CommandCompleted,
>                                    bb.command.CommandFailed,
> diff --git a/lib/toaster/orm/migrations/0021_eventlogsimports.py b/lib/toaster/orm/migrations/0021_eventlogsimports.py
> new file mode 100644
> index 00000000..328eb575
> --- /dev/null
> +++ b/lib/toaster/orm/migrations/0021_eventlogsimports.py
> @@ -0,0 +1,22 @@
> +# Generated by Django 4.2.5 on 2023-11-23 18:44
> +
> +from django.db import migrations, models
> +
> +
> +class Migration(migrations.Migration):
> +
> +    dependencies = [
> +        ('orm', '0020_models_bigautofield'),
> +    ]
> +
> +    operations = [
> +        migrations.CreateModel(
> +            name='EventLogsImports',
> +            fields=[
> +                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
> +                ('name', models.CharField(max_length=255)),
> +                ('imported', models.BooleanField(default=False)),
> +                ('build_id', models.IntegerField(blank=True, null=True)),
> +            ],
> +        ),
> +    ]
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index 1098ad3f..19c96862 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -1868,6 +1868,15 @@ class Distro(models.Model):
>      def __unicode__(self):
>          return "Distro " + self.name + "(" + self.description + ")"
>  
> +class EventLogsImports(models.Model):
> +    name = models.CharField(max_length=255)
> +    imported = models.BooleanField(default=False)
> +    build_id = models.IntegerField(blank=True, null=True)
> +
> +    def __str__(self):
> +        return self.name
> +
> +
>  django.db.models.signals.post_save.connect(invalidate_cache)
>  django.db.models.signals.post_delete.connect(invalidate_cache)
>  django.db.models.signals.m2m_changed.connect(invalidate_cache)
> diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
> index 7ec52a4b..06cc0f5c 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -211,5 +211,3 @@ class TestLandingPage(SeleniumTestCase):
>          content = self.get_page_source()
>          self.assertTrue(self.PROJECT_NAME in content,
>                          'should show builds for project %s' % self.PROJECT_NAME)
> -        self.assertFalse(self.CLI_BUILDS_PROJECT_NAME in content,
> -                         'should not show builds for cli project')
> diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
> index cb7b915b..05ee88b0 100644
> --- a/lib/toaster/tests/browser/test_layerdetails_page.py
> +++ b/lib/toaster/tests/browser/test_layerdetails_page.py
> @@ -68,6 +68,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
>          check that the new values exist"""
>  
>          self.get(self.url)
> +        self.wait_until_visible("#add-remove-layer-btn")
>  
>          self.click("#add-remove-layer-btn")
>          self.click("#edit-layer-source")
> @@ -105,7 +106,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
>          for save_btn in self.find_all(".change-btn"):
>              save_btn.click()
>  
> -        self.click("#save-changes-for-switch")
> +        self.wait_until_visible("#save-changes-for-switch", poll=3)
> +        btn_save_chg_for_switch = self.find("#save-changes-for-switch")
> +        self.driver.execute_script("arguments[0].click();", btn_save_chg_for_switch)
>          self.wait_until_visible("#edit-layer-source")
>  
>          # Refresh the page to see if the new values are returned
> @@ -134,7 +137,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
>          new_dir = "/home/test/my-meta-dir"
>          dir_input.send_keys(new_dir)
>  
> -        self.click("#save-changes-for-switch")
> +        self.wait_until_visible("#save-changes-for-switch", poll=3)
> +        btn_save_chg_for_switch = self.find("#save-changes-for-switch")
> +        btn_save_chg_for_switch.click()
>          self.wait_until_visible("#edit-layer-source")
>  
>          # Refresh the page to see if the new values are returned
> diff --git a/lib/toaster/toastergui/forms.py b/lib/toaster/toastergui/forms.py
> new file mode 100644
> index 00000000..10c7ac40
> --- /dev/null
> +++ b/lib/toaster/toastergui/forms.py
> @@ -0,0 +1,14 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +# BitBake Toaster UI tests implementation
> +#
> +# Copyright (C) 2023 Savoir-faire Linux
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +from django import forms
> +from django.core.validators import FileExtensionValidator
> +  
> +class LoadFileForm(forms.Form):
> +    eventlog_file = forms.FileField(widget=forms.FileInput(attrs={'accept': '.json'}))
> diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
> index 5cd7e211..284355e7 100644
> --- a/lib/toaster/toastergui/static/css/default.css
> +++ b/lib/toaster/toastergui/static/css/default.css
> @@ -367,3 +367,31 @@ h2.panel-title { font-size: 30px; }
>    }
>  }
>  /* End copied in from newer version of Font-Awesome 4.3.0 */
> +
> +
> +#overlay {
> +  display: flex;
> +  position: fixed;
> +  top: 0;
> +  left: 0;
> +  width: 100%;
> +  height: 100%;
> +  background-color: rgba(0, 0, 0, 0.7);
> +  align-items: center;
> +  justify-content: center;
> +  z-index: 999;
> +}
> +
> +.spinner {
> +  border: 6px solid rgba(255, 255, 255, 0.3);
> +  border-radius: 50%;
> +  border-top: 6px solid #3498db;
> +  width: 50px;
> +  height: 50px;
> +  animation: spin 1s linear infinite;
> +}
> +
> +@keyframes spin {
> +  0% { transform: rotate(0deg); }
> +  100% { transform: rotate(360deg); }
> +}
> diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
> index 041448d1..e90be696 100644
> --- a/lib/toaster/toastergui/templates/base.html
> +++ b/lib/toaster/toastergui/templates/base.html
> @@ -132,7 +132,8 @@
>              {% if project_enable %}
>              <a class="btn btn-default navbar-btn navbar-right" id="new-project-button" href="{% url 'newproject' %}">New project</a>
>              {% endif %}
> -          </div>
> +            <a class="btn btn-default navbar-btn navbar-right" id="import_page" style="margin-right: 5px !important" id="import-cmdline-button" href="{% url 'cmdlines' %}">Import command line builds</a>
> +            </div>
>        </div>
>      </nav>
>  
> diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/lib/toaster/toastergui/templates/command_line_builds.html
> new file mode 100644
> index 00000000..95944c74
> --- /dev/null
> +++ b/lib/toaster/toastergui/templates/command_line_builds.html
> @@ -0,0 +1,198 @@
> +{% extends "base.html" %}
> +{% load projecttags %}
> +{% load humanize %}
> +
> +{% block title %} Import Builds from eventlogs - Toaster {% endblock %}
> +
> +{% block pagecontent %}
> +
> +<div class="container-fluid">
> +    <div id="overlay" class="hide">
> +        <div class="spinner">
> +            <div class="fa-spin">
> +            </div>
> +        </div>
> +    </div>
> +    <div class="row">
> +        <div class="col-md-12">
> +            <div class="page-header">
> +                <div class="row">
> +                    <div class="col-md-6">
> +                        <h1>Import command line builds</h1>
> +                    </div>
> +                    {% if import_all %}
> +                    <div class="col-md-6">
> +                        <button id="import_all" type="button" class="btn btn-primary navbar-btn navbar-right">
> +                            <span class="glyphicon glyphicon-upload" style="vertical-align: top;"></span> Import All
> +                        </button>
> +                    </div> 
> +                    {% endif %}    
> +                </div>
> +            </div>
> +            {% if messages %}
> +            <div class="row-fluid" id="empty-state-{{table_name}}">
> +                {% for message in messages %}
> +                <div class="alert alert-danger">{{message}}</div>
> +                {%endfor%}
> +            </div>
> +            {% endif %}
> +            <div class="row">
> +                <h4 style="margin-left: 15px;"><strong>Import eventlog file</strong></h4>
> +                <form method="POST" enctype="multipart/form-data" action="{% url 'cmdlines' %}" id="form_file"> 
> +                    {% csrf_token %} 
> +                    <div class="col-md-6" style="padding-left: 20px;">
> +                        <div class="row">
> +                            <input type="hidden" value="{{dir}}" name="dir">
> +                            <div class="col-md-3"> {{ form.eventlog_file}}  </div>                            
> +                        </div>
> +                        <div class="row" style="padding-top: 10px;">
> +                            <div class="col-md-6"> 
> +                                <button id="file_import" type="submit" disabled="disabled" class="btn btn-default navbar-btn" >
> +                                    <span class="glyphicon glyphicon-upload" style="vertical-align: top;"></span> Import
> +                                </button>
> +                            </div>
> +                        </div>
> +                    </div>
> +                </form>
> +            </div>
> +
> +            <div class="row" style="padding-top: 20px;">
> +                <div class="col-md-8 ">
> +                    <h4><strong>Eventlogs from existing build directory: </strong>
> +                        <a href="#" data-toggle="tooltip" title="{{dir}}">
> +                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16" data-toggle="tooltip">
> +                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
> +                                <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
> +                            </svg>
> +                        </a>
> +                    </h4>
> +                    {% if files %}
> +                    <div class="table-responsive">
> +                        <table class="table col-md-6 table-bordered table-hover">
> +                            <thead>
> +                            <tr class="row">
> +                                <th scope="col">Name</th>
> +                                <th scope="col">Size</th>
> +                                <th scope="col">Action</th>
> +                            </tr>
> +                            </thead>
> +                            <tbody>
> +                                {% for file in files %}
> +                                <tr class="row" style="height: 48px;">
> +                                    <th scope="row" class="col-md-4" style="vertical-align: middle;">
> +                                        <input type="hidden" value="{{file.name}}" name="{{file.name}}">{{file.name}}
> +                                    </th>
> +                                    <td class="col-md-4 align-middle" style="vertical-align: middle;">{{file.size|filesizeformat}}</td>
> +                                    <td class="col-md-4 align-middle" style="vertical-align: middle;">
> +                                        {% if file.imported == True and file.build_id is not None %}
> +                                            <a href="{% url 'builddashboard' file.build_id %}">Build Details</a>
> +                                        {% elif request.session.file == file.name or request.session.all_builds %}
> +                                            <a data-toggle="tooltip" title="Build in progress">
> +                                                <span class="glyphicon glyphicon-upload" style="font-size: 18px; color:grey"></span>
> +                                            </a>
> +                                        {%else%}
> +                                            <a onclick="_ajax_update('{{file.name}}', false, '{{dir}}')" data-toggle="tooltip" title="Import File">
> +                                                <span class="glyphicon glyphicon-upload" style="font-size: 18px;"></span>
> +                                            </a>
> +                                        {%endif%}
> +                                    </td>
> +                                </tr>
> +                                {% endfor%}
> +                            </tbody>
> +                        </table>
> +                    </div>
> +                    {% else %}
> +                    <div class="row-fluid" id="empty-state-{{table_name}}">
> +                        <div class="alert alert-info">Sorry - no files found</div>
> +                    </div>
> +                    {%endif%}
> +                </div>
> +            </div>
> +        </div>
> +    </div>
> +</div>
> +
> +<script>
> +
> +function _ajax_update(file, all, dir){
> +    function getCookie(name) {
> +        var cookieValue = null;
> +        if (document.cookie && document.cookie !== '') {
> +            var cookies = document.cookie.split(';');
> +            for (var i = 0; i < cookies.length; i++) {
> +                var cookie = jQuery.trim(cookies[i]);
> +                // Does this cookie string begin with the name we want?
> +                if (cookie.substring(0, name.length + 1) === (name + '=')) {
> +                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
> +                    break;
> +                }
> +            }
> +        }
> +    return cookieValue;
> +    }
> +    var csrftoken = getCookie('csrftoken');
> +
> +    function csrfSafeMethod(method) {
> +        // these HTTP methods do not require CSRF protection
> +        return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
> +    }
> +    $.ajaxSetup({
> +        beforeSend: function (xhr, settings) {
> +            if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
> +                xhr.setRequestHeader("X-CSRFToken", csrftoken);
> +            }
> +        }
> +    });
> +
> +    $.ajax({
> +        url:'/toastergui/cmdline/',
> +        type: "POST",
> +        data: {file: file, all: all, dir: dir},
> +        success:function(data){
> +            window.location = '/toastergui/builds/'
> +        },
> +        complete:function(data){       
> +        },
> +        error:function (xhr, textStatus, thrownError){
> +            console.log('fail');
> +        }
> +    });
> +}
> +
> +$('#import_all').on('click', function(){
> +    _ajax_update("{{files | safe}}", true, "{{dir | safe}}");
> +});
> +
> +
> +$('#import_page').hide();
> +
> +$(function () {
> +  $('[data-toggle="tooltip"]').tooltip()
> +})
> +
> +
> +$("#id_eventlog_file").change(function(){
> +    $('#file_import').prop("disabled", false);
> +    $('#file_import').addClass('btn-primary')
> +    $('#file_import').removeClass('btn-default')
> +})
> +
> +$(document).ajaxStart(function(){
> +    $('#overlay').removeClass('hide');
> +    window.setTimeout(  
> +        function() {  
> +            window.location = '/toastergui/builds/'
> +        }, 10000)
> +});
> +
> +$( "#form_file").on( "submit", function( event ) {
> +    $('#overlay').removeClass('hide');
> +    window.setTimeout(  
> +        function() {  
> +            window.location = '/toastergui/builds/'
> +        }, 10000)
> +});
> +
> +</script>
> +
> +{% endblock %}
> diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
> index 22bbed69..589ee226 100644
> --- a/lib/toaster/toastergui/templates/landing.html
> +++ b/lib/toaster/toastergui/templates/landing.html
> @@ -15,7 +15,7 @@
>                <p>A web interface to <a href="https://www.openembedded.org">OpenEmbedded</a> and <a href="https://docs.yoctoproject.org/bitbake.html">BitBake</a>, the <a href="https://www.yoctoproject.org">Yocto Project</a> build system.</p>
>  
>  		          <p class="top-air">
> -		            <a class="btn btn-info btn-lg" href="http://docs.yoctoproject.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaster">
> +		            <a class="btn btn-info btn-lg" href="http://docs.yoctoproject.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaster" style="min-width: 460px;">
>  			            Toaster is ready to capture your command line builds
>  		            </a>
>  		          </p>
> @@ -23,7 +23,7 @@
>  		          {% if lvs_nos %}
>                      {% if project_enable %}
>  		            <p class="top-air">
> -		              <a class="btn btn-primary btn-lg" href="{% url 'newproject' %}">
> +		              <a class="btn btn-primary btn-lg" href="{% url 'newproject' %}" style="min-width: 460px;">
>  			              Create your first Toaster project to run manage builds
>  		              </a>
>  		            </p>
> @@ -42,6 +42,12 @@
>                  </div>
>                {% endif %}
>  
> +              <p class="top-air">
> +		            <a class="btn btn-info btn-lg" href="{% url 'cmdlines' %}" style="min-width: 460px;">
> +			            Import command line event logs from build directory
> +		            </a>
> +		          </p>
> +
>                <ul class="list-unstyled lead">
>                  <li>
>                    <a href="http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual">
> diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
> index bc3b0c79..62629494 100644
> --- a/lib/toaster/toastergui/urls.py
> +++ b/lib/toaster/toastergui/urls.py
> @@ -95,6 +95,7 @@ urlpatterns = [
>          # project URLs
>          url(r'^newproject/$', views.newproject, name='newproject'),
>  
> +        url(r'^cmdline/$', views.CommandLineBuilds.as_view(), name='cmdlines'),
>          url(r'^projects/$',
>              tables.ProjectsTable.as_view(template_name="projects-toastertable.html"),
>              name='all-projects'),
> diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
> index cc8517ba..a6f33bf4 100644
> --- a/lib/toaster/toastergui/views.py
> +++ b/lib/toaster/toastergui/views.py
> @@ -6,24 +6,36 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  
> +import ast
>  import re
> +import subprocess
> +import sys
> +
> +import bb.cooker
> +from bb.ui import toasterui
> +from bb.ui import eventreplay
>  
>  from django.db.models import F, Q, Sum
>  from django.db import IntegrityError
> -from django.shortcuts import render, redirect, get_object_or_404
> +from django.shortcuts import render, redirect, get_object_or_404, HttpResponseRedirect
>  from django.utils.http import urlencode
>  from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
>  from orm.models import LogMessage, Variable, Package_Dependency, Package
>  from orm.models import Task_Dependency, Package_File
>  from orm.models import Target_Installed_Package, Target_File
>  from orm.models import TargetKernelFile, TargetSDKFile, Target_Image_File
> -from orm.models import BitbakeVersion, CustomImageRecipe
> +from orm.models import BitbakeVersion, CustomImageRecipe, EventLogsImports
>  
>  from django.urls import reverse, resolve
> +from django.contrib import messages
> +
>  from django.core.exceptions import ObjectDoesNotExist
> +from django.core.files.storage import FileSystemStorage
> +from django.core.files.uploadedfile import InMemoryUploadedFile, TemporaryUploadedFile
>  from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
>  from django.http import HttpResponseNotFound, JsonResponse
>  from django.utils import timezone
> +from django.views.generic import TemplateView
>  from datetime import timedelta, datetime
>  from toastergui.templatetags.projecttags import json as jsonfilter
>  from decimal import Decimal
> @@ -32,6 +44,10 @@ import os
>  from os.path import dirname
>  import mimetypes
>  
> +from toastergui.forms import LoadFileForm
> +
> +from collections import namedtuple
> +
>  import logging
>  
>  from toastermain.logs import log_view_mixin
> @@ -41,6 +57,7 @@ logger = logging.getLogger("toaster")
>  # Project creation and managed build enable
>  project_enable = ('1' == os.environ.get('TOASTER_BUILDSERVER'))
>  is_project_specific = ('1' == os.environ.get('TOASTER_PROJECTSPECIFIC'))
> +import_page = False
>  
>  class MimeTypeFinder(object):
>      # setting this to False enables additional non-standard mimetypes
> @@ -1940,3 +1957,155 @@ if True:
>          except (ObjectDoesNotExist, IOError):
>              return toaster_render(request, "unavailable_artifact.html")
>  
> +
> +class CommandLineBuilds(TemplateView):
> +    model = EventLogsImports
> +    template_name = 'command_line_builds.html'
> +
> +    def get_context_data(self, **kwargs):
> +        context = super(CommandLineBuilds, self).get_context_data(**kwargs)
> +        #get value from BB_DEFAULT_EVENTLOG defined in bitbake.conf
> +        eventlog = subprocess.check_output(['bitbake-getvar', 'BB_DEFAULT_EVENTLOG', '--value'])
> +        if eventlog:
> +            logs_dir = os.path.dirname(eventlog.decode().strip('\n'))
> +            files = os.listdir(logs_dir)
> +            imported_files = EventLogsImports.objects.all()
> +            files_list = []
> +
> +            # Filter files that end with ".json"
> +            event_files = []
> +            for file in files:
> +                if file.endswith(".json"):
> +                    # because BB_DEFAULT_EVENTLOG is a directory, we need to check if the file is a valid eventlog
> +                    with open("{}/{}".format(logs_dir, file)) as efile:
> +                        content = efile.read()
> +                        if 'allvariables' in content:
> +                            event_files.append(file)
> +
> +            #build dict for template using db data
> +            for event_file in event_files:
> +                if imported_files.filter(name=event_file):
> +                    files_list.append({
> +                        'name': event_file,
> +                        'imported': True,
> +                        'build_id': imported_files.filter(name=event_file)[0].build_id,
> +                        'size': os.path.getsize("{}/{}".format(logs_dir, event_file))
> +                    })
> +                else:
> +                    files_list.append({
> +                        'name': event_file,
> +                        'imported': False,
> +                        'build_id': None,
> +                        'size': os.path.getsize("{}/{}".format(logs_dir, event_file))
> +                    })
> +                    context['import_all'] = True
> +
> +            context['files'] = files_list
> +            context['dir'] = logs_dir
> +        else:
> +            context['files'] = []
> +            context['dir'] = ''
> +        
> +        # enable session variable
> +        if not self.request.session.get('file'):
> +            self.request.session['file'] = ""
> +
> +        context['form'] = LoadFileForm()
> +        context['project_enable'] = project_enable
> +        return context
> +
> +    def post(self, request, **kwargs):
> +        logs_dir = request.POST.get('dir')
> +        all_files =  request.POST.get('all')
> +
> +        imported_files = EventLogsImports.objects.all()
> +        try:
> +            if all_files == 'true':
> +                # use of session variable to deactivate icon for builds in progress
> +                request.session['all_builds'] = True
> +                request.session.modified = True
> +                request.session.save()
> +
> +                files = ast.literal_eval(request.POST.get('file'))
> +                for file in files:
> +                    if imported_files.filter(name=file.get('name')).exists():
> +                        imported_files.filter(name=file.get('name'))[0].imported = True
> +                    else:
> +                        with open("{}/{}".format(logs_dir, file.get('name'))) as eventfile:
> +                            # load variables from the first line
> +                            variables = None
> +                            while line := eventfile.readline().strip():
> +                                try:
> +                                    variables = json.loads(line)['allvariables']
> +                                    break
> +                                except (KeyError, json.JSONDecodeError):
> +                                    continue
> +                            if not variables:
> +                                raise Exception("File content missing  build variables")
> +                            eventfile.seek(0)
> +                            params = namedtuple('ConfigParams', ['observe_only'])(True)
> +                            player = eventreplay.EventPlayer(eventfile, variables)
> +
> +                            toasterui.main(player, player, params)
> +                        event_log_import = EventLogsImports.objects.create(name=file.get('name'), imported=True)
> +                        event_log_import.build_id = Build.objects.last().id
> +                        event_log_import.save()
> +            else:
> +                if self.request.FILES.get('eventlog_file'):
> +                    file = self.request.FILES['eventlog_file']
> +                else:
> +                    file = request.POST.get('file')
> +                    # use of session variable to deactivate icon for build in progress 
> +                    request.session['file'] = file
> +                    request.session['all_builds'] = False
> +                    request.session.modified = True
> +                    request.session.save()
> +
> +                if imported_files.filter(name=file).exists():
> +                    imported_files.filter(name=file)[0].imported = True
> +                else: 
> +                    if isinstance(file, InMemoryUploadedFile) or isinstance(file, TemporaryUploadedFile):
> +                        variables = None
> +                        while line := file.readline().strip():
> +                            try:
> +                                variables = json.loads(line)['allvariables']
> +                                break
> +                            except (KeyError, json.JSONDecodeError):
> +                                continue
> +                        if not variables:
> +                            raise Exception("File content missing  build variables")
> +                        file.seek(0)
> +                        params = namedtuple('ConfigParams', ['observe_only'])(True)
> +                        player = eventreplay.EventPlayer(file, variables)
> +                        if not os.path.exists('{}/{}'.format(logs_dir, file.name)):
> +                            fs = FileSystemStorage(location=logs_dir)
> +                            fs.save(file.name, file)
> +                        toasterui.main(player, player, params)
> +                    else:
> +                        with open("{}/{}".format(logs_dir, file)) as eventfile:
> +                            # load variables from the first line
> +                            variables = None
> +                            while line := eventfile.readline().strip():
> +                                try:
> +                                    variables = json.loads(line)['allvariables']
> +                                    break
> +                                except (KeyError, json.JSONDecodeError):
> +                                    continue
> +                            if not variables:
> +                                raise Exception("File content missing  build variables")
> +                            eventfile.seek(0)
> +                            params = namedtuple('ConfigParams', ['observe_only'])(True)
> +                            player = eventreplay.EventPlayer(eventfile, variables)
> +                            toasterui.main(player, player, params)
> +                    event_log_import = EventLogsImports.objects.create(name=file, imported=True)
> +                    event_log_import.build_id = Build.objects.last().id
> +                    event_log_import.save()
> +                    request.session['file'] = ""
> +        except Exception:
> +            messages.add_message(
> +                self.request,
> +                messages.ERROR,
> +                "The file content is not in the correct format. Update file content or upload a different file."
> +            )
> +            return HttpResponseRedirect("/toastergui/cmdline/")
> +        return HttpResponseRedirect('/toastergui/builds/')
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15645): https://lists.openembedded.org/g/bitbake-devel/message/15645
> Mute This Topic: https://lists.openembedded.org/mt/103102308/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

