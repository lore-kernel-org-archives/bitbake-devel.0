Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BDCCD184
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.5876.1760742918464621553
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NL42MVNC;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47106fc51faso26748315e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742916; x=1761347716; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TanCxKK4WRONBkwvniAxY86hYDc8lq4CyhbwbvBOTTI=;
        b=NL42MVNCRYDRe9ZrkxhiL6X3UMqprgxWRgwcTw8f4IVFP+/X3UcJeR+N+KqaWKH7vh
         dQR1x8zqIeXmT9tyoyNKdBmpr7EIXFaD1P9wWBv0q6YmCbmDR3kffvJlXPQuLqLWrJ27
         BjiuG5alpxTwxjIOh7jKc7zSKb0432pTOZ12A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742916; x=1761347716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TanCxKK4WRONBkwvniAxY86hYDc8lq4CyhbwbvBOTTI=;
        b=TytOHCLn02Qgdnbn/rmw4kYGHESPljhjKZUHpLBkucxdQ1Xi5Nzadvpx5s+6fDbRV4
         iZnigCPvIc3XRbZhkre5uiKYN4tUgOQXXGlq/+9oQG3UvTBkCIz4rJu8Sj/bSsybHOjt
         614N2kUmJm5ob8yDkF/7RuyX/AiHsjm7w0hMSdG2aE4k+EHeSFDhwYxLRXAq5V5RI07+
         i+EwhTwztPJ9ugLp+FpnjoUF6jwox4cEM54018Tv+genIF6Yw9iwkk4erBwibRlR1c/d
         wc9F8IgE5AVL+z8ljbJ7h5NfB1OA/hOEnImhAd9RyQHb460GSTLLXd/eqXPOm0Ab7+bk
         Dk6w==
X-Gm-Message-State: AOJu0YyK60eHYdB33dxXLGGzDQHWBbXR6+MGr0DLXqlTMDokGuOEYD+w
	ibrtvT/RJnXOBiCaok45SDrogl61gmkA8Qws5h/671M2cK65LH1bbXIKup0rEJu618wB2LAUv/J
	Sd0yu7zI=
X-Gm-Gg: ASbGncuGeXbOoz9ACmCJ77AguzGFyzGZBNl8nztq89rr6orctWEMIxrt8bR62IcOaRN
	Q+l917NNyUEeXq3h7k0USqJKo9mA1Gbf5K8ze3SCFIJ0Y6RfowD8mhIUGNMN0AImMRIzs3Qf75X
	DI5AgOf5Rrp+vs8+A3SLSAIQCuhOnhooZlrtG6fPt8fxGWOT0B00NTeD9C7O2WM/yyNZcyzoCx6
	6SI8lKohWmsqsQKG+/1HJtC20uGJgWQN7A4mIbghkYatvcruVozg5papLArI7uU4lNZHm46wXw7
	RDLckLRxXblriQ/O5Cu/EQxH9IvD6w9M4c2A9RPZj+1SDIFv9rZF6zd/PgsD/X5d8cOyUttV8z8
	VqS7yfxWH4+HVgc3joyBkUGR44N3PJF+YIPWVenm47heov/iu6KrvSKO2VVrCWgw8palVwaGgRb
	laXlpOdKuJ+5aajnGw0U0SSm0ntc39rGApZT7P8YuGljamJYSJQOJ9vHtoV6NkOuNXEgASNQ4Sd
	DFwIqKQUxua
X-Google-Smtp-Source: AGHT+IH/2TfXIfV94NzzPznDfrDV7NECNHzlNBvjLzLyf0YfsaiYO0rKwpxtHUrygvC0xhZEiY9blw==
X-Received: by 2002:a5d:59af:0:b0:427:6a3:eff6 with SMTP id ffacd0b85a97d-42706a3f01fmr3196811f8f.26.1760742916448;
        Fri, 17 Oct 2025 16:15:16 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:16 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 4/5] bitbake-setup: Add an option to validate the schema
Date: Sat, 18 Oct 2025 01:14:43 +0200
Message-Id: <20251017231444.374436-5-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
References: <20251017231444.374436-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18190

From: Yoann Congal <yoann.congal@smile.fr>

This adds a dependency on "jsonschema"[0] (plus recursive dependencies),
but these dependencies are only used is the --validate option is used.

[0]: https://pypi.org/project/jsonschema/

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 38bb8099f..a96262c10 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -389,6 +389,43 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         choices[k] = options_enumerated[option_n][1]
     return choices
 
+def validate_bitbake_setup_schema(bitbake_setup_conf):
+    """
+    Validates a bitbake-setup configuration file.
+
+    Raises jsonschema.exceptions.ValidationError if the configuration file does
+    not match the schema
+    """
+    import jsonschema
+    import jsonschema.validators
+    import referencing
+    import referencing.exceptions
+
+    SCHEMAS_PATH = os.path.join(bindir, "..", "schemas")
+
+    def retrieve_resource(uri):
+        """
+        Retrieve schemas from /schemas/* URIs, reading them from
+        $BITBAKE_DIR/schemas/* files
+        """
+
+        if not uri.startswith("/schemas/"):
+            raise referencing.exceptions.NoSuchResource(uri)
+
+        schema_path = os.path.join(SCHEMAS_PATH, uri.removeprefix("/schemas/"))
+
+        if not os.path.exists(schema_path):
+            raise referencing.exceptions.NoSuchResource(uri)
+
+        with open(schema_path) as f:
+            schema = json.load(f)
+        return referencing.Resource.from_contents(schema)
+
+    registry = referencing.Registry(retrieve=retrieve_resource)
+    with open(os.path.join(SCHEMAS_PATH, "bitbake-setup.schema.json")) as f:
+        bb_setup_schema = json.load(f)
+    jsonschema.validators.validate( bitbake_setup_conf, schema=bb_setup_schema, registry=registry)
+
 def obtain_config(top_dir, settings, args, source_overrides, d):
     if args.config:
         config_id = args.config[0]
@@ -422,6 +459,9 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
         config_parameters = []
         upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
 
+    if args.validate:
+        validate_bitbake_setup_schema(upstream_config['data'])
+
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
     upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
@@ -753,6 +793,7 @@ def main():
     parser.add_argument('--setting', default=[], action='append', dest='cmdline_settings',
                         nargs=3, metavar=('SECTION', 'SETTING', 'VALUE'),
                         help='Modify a setting (for this bitbake-setup invocation only), for example "--setting default top-dir-prefix /path/to/top/dir".')
+    parser.add_argument('--validate', action='store_true', help='Validate configuration files against the schema (need jsonschema)', default=False)
 
     subparsers = parser.add_subparsers()
 

