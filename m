Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF87CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 11:05:47 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.151495.1781607944004959009
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 04:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mzz2+GzD;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso41737315e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607942; x=1782212742; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jujRiVtcVKRNJc+Sk7kYTfVN679ajyyLisbssDNdXd0=;
        b=mzz2+GzDQL20kcMTBQT3j9WOyWcmFuBfucVQnKII+zwgfuiRB00oJ7ngU0Lj6OA1R+
         nDrEm0wepgdR+YZ9zk/4bKypwfytzarqFlvN5CoSPNy1A0tG2jC319bdmrwFvdejZzqn
         WWOKqtN1mT0FJvc2cvXpCg34WplMuydNkUfY/l/oaMKJ3VfpDj6y7edT+Nrhu97nUjjj
         paTQq8GMUqWtf1Auimw4zYwBJtXCALxLLSxtkpDrHsiJWsxqIuyrfKamCIRFwtJaKS4i
         jBJrwfS9Titp5OMar0cTPynPWXurZfUCB9Xph21Cb7Y8AUXV3Cx+oUX/K17w2nM7vIBA
         Xffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607942; x=1782212742;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jujRiVtcVKRNJc+Sk7kYTfVN679ajyyLisbssDNdXd0=;
        b=BBmFgEBIwjXPtxEQJ5mg7ZqBuCFgQZYwy3/QIHn4by0V2gUgyGB10kqzV7NmDDZW0L
         QryQlWJLEdieEhIB1qUeXpB/74J6mI56nKhj0gemb1Wf+kUg2XQHhVJqkw7QFXxRXgMD
         Q10tDgsbE+IyoAxFLA34hQx7hlclQUMaH4YT8bt54eSBlxGL/FjaF7ks3YLePfHuH7Wj
         EDOHTkuFOKUzDQAXVo29tHWSSRbpIpA+GmFhOKKPJBGTG6779K/WP5aTuHR6+Oyl2w6z
         7750p+Ucaur5eoX1n2fTpIVODI0xWAIXcAREI+kYlxVxYmpH1bd1M/YpeZpY7I9bum4g
         IwXQ==
X-Gm-Message-State: AOJu0YzbiQhorczOoGmNahvEfebXVsrB9tBaIxabJt2klljtnmrGt1zy
	JleKvJLs68pAKUxPXFHO9PSakuaUU9qvLwx+vZtEcG0y9PKdj7K2Kauq
X-Gm-Gg: Acq92OHXIp4K+T53Dig9GK9kLMjnYJ8Y9umuseQM6Dl8kG161ex7OU7wwNRefYvV3Vl
	TFdV1SiJ4Q36o/ACI5usBo/zP1xeo/9D8hVRT6r+iFIrLZm4HOU49qHXhF++dSYnYCGfQhof/Fo
	V92n79f1SrZyWkzCgmzf9LlYQ6hzc0r8ylQLS0wHfbOoC9MFUOLm2no+GF8LEq4OgQDwRhaBr9M
	cMTiHmom6qmbaKanldaSDpBgL29tiL8gxji6J8ufSCMI0qrVycYQhnJljsWeTkAV5urdaMXORPR
	jjucsYVhV52K9vucciv2+qIf3MK5j/rmOnUCm9rp4R0NweYw1aS29V4xB18dlFkgqCAddrqdQ9a
	ifyTdDFA8Xf52jb3WOIJoHimRgDyhCrd4TX7m03ab+QAGENe7ZJzOR/qv/HrO55syEFY42O3HQl
	cA7KiGJdRpe/UBQyEYbBby0W5CAlErI11ygUbiA8g6Rb1JpJ0eh/xW1nqVP7bMvh3SZ5SxBwpHW
	1coqhMgPd8j9WU/UXavhtPNzSw=
X-Received: by 2002:a05:600c:c1d7:20b0:492:1e36:4270 with SMTP id 5b1f17b1804b1-492201388b7mr146120535e9.36.1781607941485;
        Tue, 16 Jun 2026 04:05:41 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea9563b8sm272016305e9.2.2026.06.16.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:05:40 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 16 Jun 2026 13:05:37 +0200
Subject: [PATCH RFC] bitbake-setup: add source choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-bb-setup-source-choices-integrated-tests-v1-1-a1e51bdeead5@toradex.com>
X-B4-Tracking: v=1; b=H4sIAAAuMWoC/x3NQQqDMBBG4avIrDtgIgbaq5QuYvJXZ5NIZiwF8
 e4NXX6b905SNIHSYzip4SMqtXS420Bpi2UFS+4mP/owBhd4WVhhx85aj5bAaauSoCzFsLZoyGx
 QU56Tz1OcXLzPoJ7bG97y/a+er+v6AeDmikh6AAAA
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 11:05:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19703

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Allow setup configuration files to define named source sets with a
top-level source-choices property.

BitBake configurations can use source-selection to name one source choice
or list the choices the user may select from. Single-choice selections
are used directly, while multi-choice selections can be passed on the
command line or selected interactively.

Store the selected source choice in config-upstream.json so status and
update continue to use the same source set after init.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
In a previously sent series [1], the idea came up to allow defining
multiple named sets of sources in the top level configuration.

A configuration could then select a set of sources. This way, multiple
setups can share configuration even if they use, for example, different
source revisions. Such a change would allow folding the current Poky
master, wrynose and whinlatter setups into one config file:

https://git.openembedded.org/bitbake/tree/default-registry/configurations

This patch adds a top-level "source-choices" that can contain named
sets of sources.

Alex's original idea was to have source choices be user selectable, with
a possible later add-on of an allow list to limit sources to certain
configs. Possibly, the source choices schema would also have an expires
field.

In this proposal, I instead added an optional "source-selection"
property to the configurations node. This would behave as follows:
  * If the selected config has no "source-selection": use top-level
    "sources"
  * If the selected config has "source-selection", but no top-level
    "source-choices" is present: error out
  * If the selected config has "source-selection" and "source-choices"
    is present:
    - When "source-selection" is a string or 1-element array, choice is
      made automatically
    - When "source-selection" is an array with multiple entries, user
      has to make a choice out of the given options

A BitBake configuration opts into source choices by setting
"source-selection". Configurations without "source-selection" continue
to use top-level "sources".

This "source-selection" mechanism has a few benefits to me:
  * Limits each configuration to the source choices that make sense for
    it.
  * Allows defining configs that are tied to a given set of sources
    without requiring more choices
  * Configs already have an "expires" field, with this things can be
    tightly coupled and source-choices do not need to be aware of
    expirations
  * Existing configs do not change behaviour even if "source-choices" is
    added to the top-level.

Drawbacks:
  * Positional arguments can now be a choice for oe-fragments-one-of or
    for source-selection. This follows the existing oe-fragments-one-of
    command line style.

Points for review:
  * Should we allow "sources" to not be present if "source-choices" are
    defined?
  * Should "source-selection" share the existing positional argument
    namespace with "oe-fragments-one-of", or should source choices use a
    separate command line mechanism?

Sending this as an RFC to get some feedback on the shape of this patch
before adding documentation and test coverage.

[1] https://lore.kernel.org/bitbake-devel/CANNYZj9rKRS0CD-LGq=phvB_T1XS+SmR5Uti0p8tu49PtTm-QA@mail.gmail.com/
---
 bin/bitbake-setup                      | 63 ++++++++++++++++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json | 42 +++++++++++++++++++++++
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2829e753e145..4aeb78798f86 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -462,8 +462,14 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
+def get_configured_sources(config):
+    selected_source_choice = config.get("selected-source-choice")
+    if selected_source_choice is not None:
+        return config["data"]["source-choices"][selected_source_choice]["sources"]
+    return config["data"]["sources"]
+
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
-    layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(get_configured_sources(config), config["source-overrides"]["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
@@ -594,6 +600,38 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         choices[k] = options_enumerated[option_n][1]["name"]
     return choices
 
+def choose_source_choice(possibilities, selection, parameters, non_interactive):
+    possible_choices = selection if isinstance(selection, list) else [selection]
+    if not possible_choices:
+        raise Exception("Source selection does not contain any source choices.")
+
+    missing_choices = [c for c in possible_choices if c not in possibilities]
+    if missing_choices:
+        raise Exception("Unknown source choice(s): {}".format(missing_choices))
+
+    if len(possible_choices) == 1:
+        only_choice = possible_choices[0]
+        logger.plain("\nSelecting the only available source choice {}".format(only_choice))
+        return only_choice
+
+    cmdline_choices = [c for c in possible_choices if c in parameters]
+    if len(cmdline_choices) > 1:
+        raise Exception("Options specified on command line do not allow a single selection "
+                        f"from source choices {possible_choices}, please remove one or more from {parameters}")
+    if len(cmdline_choices) == 1:
+        return cmdline_choices[0]
+
+    if non_interactive:
+        raise Exception(f"Unable to choose from source choices in non-interactive mode: {possible_choices}")
+
+    logger.plain("")
+    print_configs("Available source choices",
+                  possible_choices,
+                  [possibilities[c]["description"] for c in possible_choices])
+    choice_n = int_input([i[0] for i in list(enumerate(possible_choices, 1))],
+                         "\nPlease select one of the above source choices by its number: ") - 1
+    return possible_choices[choice_n]
+
 def obtain_config(top_dir, registry, args, source_overrides, d):
     if args.config:
         config_id = args.config[0]
@@ -633,8 +671,27 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
         upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
 
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
+
+    source_selection = upstream_config['bitbake-config'].get('source-selection')
+
+    selected_source_choice = None
+    if source_selection is None:
+        if 'sources' not in upstream_config['data']:
+            raise Exception("Configuration template does not define 'sources', and the selected BitBake configuration does not select a source choice.")
+    else:
+        source_choices = upstream_config['data'].get('source-choices')
+        if source_choices is None:
+            raise Exception("BitBake configuration uses 'source-selection' but the configuration template does not define 'source-choices'.")
+        selected_source_choice = choose_source_choice(source_choices, source_selection, config_parameters[1:], args.non_interactive)
+        upstream_config['selected-source-choice'] = selected_source_choice
+
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
-    upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
+
+    non_interactive_cmdline_options = [config_id, upstream_config['bitbake-config']['name']]
+    if selected_source_choice is not None:
+        non_interactive_cmdline_options.append(selected_source_choice)
+    non_interactive_cmdline_options += sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
+    upstream_config['non-interactive-cmdline-options'] = non_interactive_cmdline_options
     upstream_config['source-overrides'] = source_overrides
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
@@ -952,7 +1009,7 @@ def build_status(top_dir, settings, args, d, update=False):
             bb.process.run(["git", "-C", confdir, "restore", "config-upstream.json"])
         return
 
-    layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(get_configured_sources(current_upstream_config), current_upstream_config["source-overrides"]["sources"])
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 99f47f73d0a6..149f1ebab558 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -15,6 +15,30 @@
         "sources": {
             "$ref": "layers.schema.json#/properties/sources"
         },
+        "source-choices": {
+            "type": "object",
+            "description": "Named choices of sources that configurations can select from with source-selection",
+            "patternProperties": {
+                ".*": {
+                    "type": "object",
+                    "required": [
+                        "description",
+                        "sources"
+                    ],
+                    "properties": {
+                        "description": {
+                            "type": "string",
+                            "description": "Human-readable description of the source choice"
+                        },
+                        "sources": {
+                            "$ref": "layers.schema.json#/properties/sources"
+                        }
+                    },
+                    "additionalProperties": false
+                }
+            },
+            "additionalProperties": false
+        },
         "expires": {
             "type": "string",
             "description": "End of life date for this configuration, in ISO 8601 format (YYYY-MM-DD)"
@@ -73,6 +97,24 @@
                                 "type": "string",
                                 "description": "OE-template configuration"
                             },
+                            "source-selection": {
+                                "description": "Source choice, or list of source choices, that can be used with this configuration",
+                                "oneOf": [
+                                    {
+                                        "type": "string",
+                                        "description": "Named source choice to use for this configuration"
+                                    },
+                                    {
+                                        "type": "array",
+                                        "description": "List of named source choices that can be chosen from for this configuration",
+                                        "minItems": 1,
+                                        "items": {
+                                            "type": "string",
+                                            "description": "Named source choice"
+                                        }
+                                    }
+                                ]
+                            },
                             "oe-fragments": {
                                 "$anchor": "oe-fragments",
                                 "type": "array",

---
base-commit: 7e6466f48191c1e4ab9b91705deb237eff2c7f01
change-id: 20260616-bb-setup-source-choices-integrated-tests-5c2d3a31a95e

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


