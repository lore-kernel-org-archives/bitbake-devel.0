Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 35B296FF73
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 13:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDUwof012777 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fp_6jxncMTqR for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:58 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDUqCX012773
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:53 +0100
Message-ID: <1460640652.9308.174.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Apr 2016 14:30:52 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] providers: Add PREFERRED_RPROVIDER support
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Apr 2016 13:30:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Sometimes you can end up in a situation where you need to specify that
a specific runtime entity should be provided by a specific entry.

An example of this is bluez where you could end up in a situation where
for example:

NOTE: multiple providers are available for runtime libasound-module-bluez (bluez4, bluez5)
NOTE: consider defining a PREFERRED_PROVIDER entry to match libasound-module-bluez
NOTE: multiple providers are available for runtime bluez-hcidump (bluez-hcidump, bluez5)
NOTE: consider defining a PREFERRED_PROVIDER entry to match bluez-hcidump

The only option here is to set something like PREFERRED_PROVIDER_bluez4 = "bluez4"
which is clearly not very informative.

I've actually held off adding RPROVIDER support for a long while as this
does have sigificant potential for misuse. It doesn't for example allow
multiple runtime providers of the same name to coexist, that simply isn't
supported. It therefore doesn't replace some of the name mappings such
as busybox verses coreutils that OE-Core faces as that is a different
problem with different constraints. This mechanism is simply to provide
bitbake with a hint to decide what the dependency tree should look like.

Also, this allows us to stop printing a confusing message telling the user
to set PREFERRED_PROVIDER when the setting needed would be rather ambiguous.

[YOCTO #5044]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 8195d62..563a091 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -317,32 +317,50 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
 
     eligible = _filterProviders(providers, item, cfgData, dataCache)
 
-    # Should use dataCache.preferred here?
-    preferred = []
-    preferred_vars = []
-    pns = {}
-    for p in eligible:
-        pns[dataCache.pkg_fn[p]] = p
-    for p in eligible:
-        pn = dataCache.pkg_fn[p]
-        provides = dataCache.pn_provides[pn]
-        for provide in provides:
-            prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, True)
-            #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
-            if prefervar in pns and pns[prefervar] not in preferred:
-                var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
-                logger.verbose("selecting %s to satisfy runtime %s due to %s", prefervar, item, var)
-                preferred_vars.append(var)
-                pref = pns[prefervar]
-                eligible.remove(pref)
-                eligible = [pref] + eligible
-                preferred.append(pref)
+    # First try and match any PREFERRED_RPROVIDER entry
+    prefervar = cfgData.getVar('PREFERRED_RPROVIDER_%s' % item, True)
+    foundUnique = False
+    if prefervar:
+        for p in eligible:
+            pn = dataCache.pkg_fn[p]
+            if prefervar == pn:
+                logger.verbose("selecting %s to satisfy %s due to PREFERRED_RPROVIDER", pn, item)
+                eligible.remove(p)
+                eligible = [p] + eligible
+                foundUnique = True
+                numberPreferred = 1
                 break
 
-    numberPreferred = len(preferred)
+    # If we didn't find an RPROVIDER entry, try and infer the provider from PREFERRED_PROVIDER entries
+    # by looking through the provides of each eligible recipe and seeing if a PREFERRED_PROVIDER was set.
+    # This is most useful for virtual/ entries rather than having a RPROVIDER per entry.
+    if not foundUnique:
+        # Should use dataCache.preferred here?
+        preferred = []
+        preferred_vars = []
+        pns = {}
+        for p in eligible:
+            pns[dataCache.pkg_fn[p]] = p
+        for p in eligible:
+            pn = dataCache.pkg_fn[p]
+            provides = dataCache.pn_provides[pn]
+            for provide in provides:
+                prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, True)
+                #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
+                if prefervar in pns and pns[prefervar] not in preferred:
+                    var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
+                    logger.verbose("selecting %s to satisfy runtime %s due to %s", prefervar, item, var)
+                    preferred_vars.append(var)
+                    pref = pns[prefervar]
+                    eligible.remove(pref)
+                    eligible = [pref] + eligible
+                    preferred.append(pref)
+                    break
+
+        numberPreferred = len(preferred)
 
     if numberPreferred > 1:
-        logger.error("Trying to resolve runtime dependency %s resulted in conflicting PREFERRED_PROVIDER entries being found.\nThe providers found were: %s\nThe PREFERRED_PROVIDER entries resulting in this conflict were: %s", item, preferred, preferred_vars)
+        logger.error("Trying to resolve runtime dependency %s resulted in conflicting PREFERRED_PROVIDER entries being found.\nThe providers found were: %s\nThe PREFERRED_PROVIDER entries resulting in this conflict were: %s. You could set PREFERRED_RPROVIDER_%s" % (item, preferred, preferred_vars, item))
 
     logger.debug(1, "sorted runtime providers for %s are: %s", item, eligible)
 
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2fc20cf..2685627 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -453,7 +453,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
                             event._item,
                             ", ".join(event._candidates))
-                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                rtime = ""
+                if event._is_runtime:
+                    rtime = "R"
+                logger.info("consider defining a PREFERRED_%sPROVIDER entry to match %s" % (rtime, event._item))
                 continue
             if isinstance(event, bb.event.NoProvider):
                 if event._runtime:



