Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4A46873C0D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Mar 2015 12:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2UCtLFO005410; Mon, 30 Mar 2015 13:56:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JJA6i2U4RQy4; Mon, 30 Mar 2015 13:56:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2UCuW2f005464
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 30 Mar 2015 13:56:43 +0100
Message-ID: <1427720192.14020.301.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 30 Mar 2015 13:56:32 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH WIP] bitbake-layers: Convert flatten to use collections.bbappends
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
X-List-Received-Date: Mon, 30 Mar 2015 12:56:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

flatten support currently looks broken since it doesn't appear to
deal with handling "%" support in bbappend file names.

This patch convert it to use collections.get_file_appends() which
correctly handles "%" support.

[FIXME: Also converts collections.appendlist -> collections.bbappends
but this code also appears to be missing "%" support?]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

[Paul: I have to admit I'm struggling to understand what first_append does
so was struggling to further clean this up]

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 9824629..e30e0f6 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -622,31 +622,27 @@ build results (as the layer priority order has effectively changed).
                                     logger.warn('Overwriting file %s', fdest)
                             bb.utils.copyfile(f1full, fdest)
                             if ext == '.bb':
-                                if f1 in self.bbhandler.cooker.collection.appendlist:
-                                    appends = self.bbhandler.cooker.collection.appendlist[f1]
-                                    if appends:
-                                        logger.plain('  Applying appends to %s' % fdest )
-                                        for appendname in appends:
-                                            if layer_path_match(appendname):
-                                                self.apply_append(appendname, fdest)
+                                for append in self.bbhandler.cooker.collection.get_file_appends(f1full):
+                                    if layer_path_match(append):
+                                        logger.plain('  Applying append %s to %s' % (append, fdest))
+                                        self.apply_append(append, fdest)
                                     appended_recipes.append(f1)
 
         # Take care of when some layers are excluded and yet we have included bbappends for those recipes
-        for recipename in self.bbhandler.cooker.collection.appendlist.iterkeys():
+        for b in self.bbhandler.cooker.collection.bbappends:
+            (recipename, appendname) = b
             if recipename not in appended_recipes:
-                appends = self.bbhandler.cooker.collection.appendlist[recipename]
                 first_append = None
-                for appendname in appends:
-                    layer = layer_path_match(appendname)
-                    if layer:
-                        if first_append:
-                            self.apply_append(appendname, first_append)
-                        else:
-                            fdest = appendname[len(layer):]
-                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
-                            bb.utils.mkdirhier(os.path.dirname(fdest))
-                            bb.utils.copyfile(appendname, fdest)
-                            first_append = fdest
+                layer = layer_path_match(appendname)
+                if layer:
+                    if first_append:
+                        self.apply_append(appendname, first_append)
+                    else:
+                        fdest = appendname[len(layer):]
+                        fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
+                        bb.utils.mkdirhier(os.path.dirname(fdest))
+                        bb.utils.copyfile(appendname, fdest)
+                        first_append = fdest
 
         # Get the regex for the first layer in our list (which is where the conf/layer.conf file will
         # have come from)
@@ -722,7 +718,7 @@ build results (as the layer priority order has effectively changed).
 Lists recipes with the bbappends that apply to them as subitems.
 """
         self.init_bbhandler()
-        if not self.bbhandler.cooker.collection.appendlist:
+        if not self.bbhandler.cooker.collection.bbappends:
             logger.plain('No append files found')
             return 0
 



