Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C1CD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 18:04:30 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25846.1781805863691147893
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 11:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Eh+hI0k5;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b7866869so11660705e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805862; x=1782410662; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHndwTHzfB+3eu8K2CCyTayy9Oih0y97irr4BtqaIxA=;
        b=Eh+hI0k5MLAunM1lF4Lqh7Ngp6/2cP5r0nh+EZZBAXrH07NwFDwfqgDGDcvL6QPKOG
         UrvB9sZ8GuXnqLML578P2mTu9/xG2yUE8LPo8gAWb5j7/l9A2ME6vuNk5waY2M6gzMdY
         9XifQ2Imh0jHjkhtC81mlK3Q5ax8htMRO/ueIq9jTCyVeLQz//1sLGWO6enIX9N3PJAn
         PyM+6A4C624hE1TYDn/f54IkgnZ/mVl2Pi9qxvQx7TSYpPKjxLm+LHrSITYIUSlzzLiV
         k9aBPPu6Wp6O68f3N1xc/EWisx1PRT8Kw9IhGJwPMs63wF8KiVjCMcBNF12hhXoOPYGD
         7hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805862; x=1782410662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nHndwTHzfB+3eu8K2CCyTayy9Oih0y97irr4BtqaIxA=;
        b=ijlAozijai/onNkMsEf+XbCwRd9ocAd1xOqnSbyix5l4w7NGs8RsN6upb077o0zSxB
         CJzit27iWNDh1QwGebA+Cs6oXWmFz6M1C7IPRh11v0Yj7qPLISRPnGopHvUNvwUSV2s+
         lSVWMLNcrBs4ZIqvg60e9v5fo04REDuCfdobUu0l9BYdM3y/UYNQhLcmnPIudtmFJOa3
         b9i2IFTef3u08/F4tlhv7riMHqI6rOe24DKMXzYQV3cv+uWIneg0r9mFfBa2vVQ10BbS
         P5dtpohHC4OJ67e4p0aKEtSSv1AmDqi/UYGAyPOCBma0kEucluG1fdA9pUFl1kT8IYAK
         tzKg==
X-Gm-Message-State: AOJu0YxrFEUNaiEUXhE4IoRtHFHg4LByVAvnFblmlDvA2zv/OGNnsbrX
	h5SV4uZKGd81UBgEWCe3UWYUH9ZMwETQZJm1wfuRA3uwfVTzD6ASW/LNX/L4vvUq
X-Gm-Gg: AfdE7ckPYwWGYBQMznxGIseLz1ZC0z9gnhQcEo51GlvjwQd0EYErRSV4Kruemc9whIi
	UEQnpyugc5OhwZzbDBMjg6BpyQ28bTmx2pnFvPGyrGj40m6Izan67nfLsKe0zQZSoU8qPbfg2JH
	dJaUiC9OLwA9zRJKLygOA8UQTOV7/C6GNmtntVokMlZIFEHYIx/uj0aU8wcsU+qOjo3iYhpAyh8
	K2WCUJJkE48sw0jm9NKh3/2C9ZUWC7ufOrKcS2AMpzxWifu7YM1rmwtUv7Xyshg5pcOAPEGVoRf
	OUyQMYX/MUAXF5xuafFFza+eRum/T8BhtDN4f67jMKgOvFbQaIIhz4hOPhY746oWpNZsELw9Ovz
	3rminNLfQlSaR1eCA7HgjpeosjWIXGMrucDsKLKeTBRxro3gB6RRxs05V8L814cpHwUz8yQZcFO
	yacsUiXG1Tg5CSQuNCoW7e1Lrk8aZ0nHV3Zd2C2JbgXGD6KenedqgAbMp//PQjmEf1Gjsz2LBlC
	gQDS0sIlTk0LZgg
X-Received: by 2002:a05:600c:528c:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-4923f6baae0mr10420025e9.33.1781805861570;
        Thu, 18 Jun 2026 11:04:21 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47b48sm7813665e9.0.2026.06.18.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:04:20 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 18 Jun 2026 20:04:04 +0200
Subject: [PATCH RFC v2 1/2] bitbake-setup: add source choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bb-setup-source-choices-integrated-tests-v2-1-66b3b438f073@toradex.com>
References: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
In-Reply-To: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 18:04:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19743

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Allow configuration files to define source-choices instead of sources.
A source choice is selected before the BitBake configuration and then
used as the source set for checkout, status and update operations.

The positional command line grammar becomes source-first for configs
that use source-choices:

  bitbake-setup init <config> [source-choice] [bitbake-config] [fragments...]

This keeps parsing deterministic when source choice names, BitBake
configuration names and fragment choice names overlap. The selected
source choice is stored in config-upstream.json and included in the
recorded non-interactive command line options so replay remains explicit.

Source choices can carry their own expires field. Expired choices are
not offered during interactive selection or auto-selection, but an
explicit expired choice is still accepted with the same warning style as
expired configurations.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 bin/bitbake-setup                      | 71 ++++++++++++++++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json | 41 ++++++++++++++++++++
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 664bffee310d..1594d6f00dfb 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -462,8 +462,14 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
+def get_selected_sources(config):
+    source_choices = config["data"].get("source-choices")
+    if source_choices is not None:
+        return source_choices[config["selected-source-choice"]]["sources"]
+    return config["data"]["sources"]
+
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
-    layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(get_selected_sources(config), config["source-overrides"]["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
@@ -594,6 +600,44 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         choices[k] = options_enumerated[option_n][1]["name"]
     return choices
 
+def choose_source_choice(source_choices, source_choice_arg, non_interactive):
+    if not source_choices:
+        raise Exception("Configuration template must define at least one source choice.")
+
+    source_choice_names = sorted(source_choices.keys())
+    not_expired_choices = [k for k in source_choice_names if not has_expired(source_choices[k].get("expires", None))]
+    if source_choice_arg is not None:
+        if source_choice_arg in source_choices:
+            return source_choice_arg
+        raise Exception("Source choice {} not found; replace with one of {}".format(source_choice_arg, source_choice_names))
+
+    if len(not_expired_choices) == 1:
+        only_choice = not_expired_choices[0]
+        logger.plain("\nSelecting the only available source choice {}".format(only_choice))
+        return only_choice
+
+    if not not_expired_choices:
+        raise Exception("No unexpired source choices available.")
+
+    if non_interactive:
+        raise Exception("Unable to choose from source choices in non-interactive mode: {}".format(not_expired_choices))
+
+    descs = []
+    for c in not_expired_choices:
+        d = source_choices[c]["description"]
+        expiry_date = source_choices[c].get("expires", None)
+        if expiry_date:
+            d += f" (supported until {expiry_date})"
+        descs.append(d)
+
+    logger.plain("")
+    print_configs("Available source choices",
+                  not_expired_choices,
+                  descs)
+    choice_n = int_input([i[0] for i in list(enumerate(not_expired_choices, 1))],
+                         "\nPlease select one of the above source choices by its number: ") - 1
+    return not_expired_choices[choice_n]
+
 def obtain_config(top_dir, registry, args, source_overrides, d):
     if args.config:
         config_id = args.config[0]
@@ -632,9 +676,30 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
         config_parameters = []
         upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
 
+    selected_source_choice = None
+    has_sources = 'sources' in upstream_config['data']
+    has_source_choices = 'source-choices' in upstream_config['data']
+    if has_sources == has_source_choices:
+        raise Exception("Configuration template must define exactly one of 'sources' or 'source-choices'.")
+    if has_source_choices:
+        source_choices = upstream_config['data']['source-choices']
+        source_choice_arg = config_parameters[0] if config_parameters else None
+        selected_source_choice = choose_source_choice(source_choices, source_choice_arg, args.non_interactive)
+        if source_choice_arg is not None:
+            config_parameters = config_parameters[1:]
+        expiry_date = source_choices[selected_source_choice].get("expires", None)
+        if has_expired(expiry_date):
+            logger.warning("The selected source choice {} is no longer supported after {}. Please consider changing to a supported source choice.".format(selected_source_choice, expiry_date))
+        upstream_config['selected-source-choice'] = selected_source_choice
+
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
-    upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
+    upstream_config['non-interactive-cmdline-options'] = (
+        [config_id] +
+        ([selected_source_choice] if selected_source_choice is not None else []) +
+        [upstream_config['bitbake-config']['name']] +
+        sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
+    )
     upstream_config['source-overrides'] = source_overrides
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
@@ -952,7 +1017,7 @@ def build_status(top_dir, settings, args, d, update=False):
             bb.process.run(["git", "-C", confdir, "restore", "config-upstream.json"])
         return
 
-    layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(get_selected_sources(current_upstream_config), current_upstream_config["source-overrides"]["sources"])
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 99f47f73d0a6..bf5065eb496b 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -15,6 +15,35 @@
         "sources": {
             "$ref": "layers.schema.json#/properties/sources"
         },
+        "source-choices": {
+            "type": "object",
+            "description": "Named choices of sources to select from",
+            "minProperties": 1,
+            "patternProperties": {
+                ".+": {
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
+                        },
+                        "expires": {
+                            "type": "string",
+                            "description": "End of life date for this source choice, in ISO 8601 format (YYYY-MM-DD)"
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
@@ -152,5 +181,17 @@
             ]
         }
     },
+    "oneOf": [
+        {
+            "required": [
+                "sources"
+            ]
+        },
+        {
+            "required": [
+                "source-choices"
+            ]
+        }
+    ],
     "additionalProperties": false
 }

-- 
2.43.0


