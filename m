Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40681D3B7E2
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 20:07:58 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2299.1765224472152225008
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 12:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IF0II5hM;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79e7112398so31926666b.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765224470; x=1765829270; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/EWtLWVJUlQQyN40+m9KJ/igaUb6cTFrcMCAJK/hKI=;
        b=IF0II5hM4C5i5YYsawIvRi2DJJNubdn0Zcy2zC4RcIOVykFO0+wWMePrJT1N7LeKNQ
         I6Kj2qIqm9m1tDi/RBDpdHEsBGtH5wvtA8rnXVVrpYkM0+41RNt0AN9p9sIDhFM6JsDE
         aLtn4hxWKi+pLjk229MvxgRefgT0PHmwoEX9g7tIfwZ8G08nbHL5Be0K6oo+OqLxJeDx
         yue7hUzuInod38fGQPO0aSPfpDRiP5ArJ5M2rA9pz2d61yuKj5wJ1SwiQpudUl3r9obA
         mCsjoO70GqmpNO2nt0j2iBjm4QGD7lQBh42tD/ACgApykjbxCY+/4WhsLhM7prIxfqOi
         jnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765224470; x=1765829270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/EWtLWVJUlQQyN40+m9KJ/igaUb6cTFrcMCAJK/hKI=;
        b=bf9kul/K36NJvqe0s8VWSCaFCovvT2epuwOWaw8lhmjqIWGlsIYpfy3yO6rNXubdWp
         2Se5kBuU7ar/6pA3J9hAMwnHFiGUErxJdhdZkyHq7X2+vq7p1VlJACqtAFcB83W5lZAX
         MCKNkWJxwejT8dJwtB5llmv0zLRpFblauE5t1Ws2Tfn+JvwSfMJeB54FWVGQBY0ee0R3
         Mbg3Uy5IXbtKZXvU60uOS4d7NYa/iYaDgSDvzGTrC9Ze1dmVeynv9L8joQM+9zrJfMn4
         4lwH56u7U6kx6fIZIl5I+075WFWQqVRJct5FCEZU409Emn1UhLW503QvFr1ty37SOzo3
         qsHg==
X-Gm-Message-State: AOJu0YzVZKJdHYpwP7FTGiXe2VHthQiXaQXGORGX1hgm7tFpjVmiOxOb
	laLNL3u1CbAu7auRXMm8bXaaxP/7hl/IHN1pDlicCSf5m/2SV9TB+Nv9Vuwl4g==
X-Gm-Gg: ASbGncsyKNkLgPTtvUNj3Rv0RKJHl+WAib5VHqs0VwSmwLP5I0napD6teTklIZ1OZj9
	t2t1xBCCdaRt0FVcN5fIL4SblwTXZNVrgmaPVsr6Amwi0OQvYNEMwo0Uj/BHOwOq95ElPTweYX8
	U5XJjgHwz3+57bxQHhHm4JIvNpzVrt+5ZbjvgGi4tjdwbN2oxaizgjf4ZdDSAAlwndr+meqGFgv
	Usw7iWtiyOcRFaq2m167Oar+DMTg+zXbpp0kEMWx8P76TdWcfwELMHAGgvlirNzTwP4ZeD3QJRa
	sXw20sssWdeuK409OJE7P6wrjnL9X/4m/cSZiEAR5waOmm153C+stFCyLo6vFNgQ8nL1jeU5wRM
	yyS9pvSGoVxlI8KSdn2iNIU7mUHShANJlTbqcEVx/kj+XsXJp6yeoYbQ0gUB5J/GKxsOBMGBy65
	KUCFnkCdTJ4w67NIA=
X-Google-Smtp-Source: AGHT+IE8RjWdWst3WgO0/0wawI4YcPqBb0GN/xw4e5gwyj2wnOcTqQlwh0uEuEr9+4DMgOWAnW40IQ==
X-Received: by 2002:a17:907:7e9c:b0:b79:c233:c8a7 with SMTP id a640c23a62f3a-b7a2432d1bcmr917836066b.21.1765224470163;
        Mon, 08 Dec 2025 12:07:50 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:c90a:1ef9:90ed:ab9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f426413esm1210828366b.0.2025.12.08.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 12:07:49 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	adrian.freihofer@gmail.com
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] bblayers/query: Add --show-variants option to display BBCLASSEXTEND variants
Date: Mon,  8 Dec 2025 21:07:47 +0100
Message-ID: <20251208200747.19602-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 20:07:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18555

The bitbake-layers show-recipes command was hiding BBCLASSEXTEND recipe
variants (e.g., devupstream, nativesdk, cross-canadian) by design, to
avoid clutter in the output. However, this made it impossible to see
recipes like linux-firmware's devupstream variant which uses git snapshots
instead of release tarballs.

This patch adds a new --show-variants option to show-recipes that
allows users to view all BBCLASSEXTEND variants when needed, while
maintaining the default behavior of hiding them for a cleaner output.

Example usage:
  bitbake-layers show-recipes --show-variants linux-firmware

This will now show both:
  - Base version: 1:20251011
  - Devupstream version: 1:20251011+git

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2: keep only long option
---
 bitbake/lib/bblayers/query.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index eb7cb465b4..7b8d1afd71 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -52,7 +52,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None, args.mc)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None, args.mc, False)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -119,9 +119,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist, args.mc)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist, args.mc, args.show_variants)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits, mc):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits, mc, show_variants=False):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -203,8 +203,10 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                 # We only display once per recipe, we should prefer non extended versions of the
                 # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
                 # which would otherwise sort first).
+                # However, if show_variants is True, we show all BBCLASSEXTEND variants.
                 if realfn[1] and realfn[0] in self.tinfoil.cooker.recipecaches[mc].pkg_fn:
-                    continue
+                    if not show_variants:
+                        continue
 
                 if inherits:
                     matchcount = 0
@@ -229,7 +231,11 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     for prov in allproviders[p]:
                         provfile = bb.cache.virtualfn2realfn(prov[1])[0]
                         provlayer = self.get_file_layer(provfile)
-                        provs.append((provfile, provlayer, prov[0]))
+                        # When show_variants is True, use the virtual filename to distinguish BBCLASSEXTEND variants
+                        if show_variants:
+                            provs.append((prov[1], provlayer, prov[0]))
+                        else:
+                            provs.append((provfile, provlayer, prov[0]))
                         if provlayer != preflayer:
                             multilayer = True
                         if prov[0] != pref[0]:
@@ -238,10 +244,12 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                         if not items_listed:
                             logger.plain('=== %s ===' % title)
                             items_listed = True
+                        # When show_variants is True, use the virtual filename for preference check
+                        pref_cmp_file = pref[1] if show_variants else preffile
                         print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
                         for (provfile, provlayer, provver) in provs:
-                            if provfile != preffile:
-                                print_item(provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
+                            if provfile != pref_cmp_file:
+                                print_item(bb.cache.virtualfn2realfn(provfile)[0] if show_variants else provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
                         # Ensure we don't show two entries for BBCLASSEXTENDed recipes
                         preffiles.append(preffile)
 
@@ -530,6 +538,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('-l', '--layer', help='only list recipes from the selected layer', default='')
         parser_show_recipes.add_argument('-b', '--bare', help='output just names without the "(skipped)" marker', action='store_true')
+        parser_show_recipes.add_argument('--show-variants', help='show all BBCLASSEXTEND recipe variants (e.g., devupstream, nativesdk)', action='store_true')
         parser_show_recipes.add_argument('--mc', help='use specified multiconfig', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
-- 
2.43.0


