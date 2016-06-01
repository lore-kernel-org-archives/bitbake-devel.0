Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9FA56773C1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3BC007479; Wed, 1 Jun 2016 13:37:07 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EV_bMhir6RBq; Wed,  1 Jun 2016 13:37:07 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxDW007451
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nx-AK; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:28 +0100
Message-Id: <1464784607-2985-9-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 09/28] data/event/siggen: Fix various exceptions [FIXME]
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:11 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py   | 1 +
 lib/bb/event.py  | 3 ++-
 lib/bb/siggen.py | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 48d990d..60b2033 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -410,6 +410,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
         deps -= set(varflags.get("vardepsexclude", "").split())
     except Exception as e:
         bb.warn("Exception during build_dependencies for %s" % key)
+        bb.warn(str(e))
         raise
     return deps, value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), str(execs)))
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 6fb3712..023300b 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -157,7 +157,8 @@ def fire_ui_handlers(event, d):
                 _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
              else:
                 _ui_handlers[h].event.send(event)
-        except:
+        except Exception as e:
+            print(str(e))
             errors.append(h)
     for h in errors:
         del _ui_handlers[h]
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index db3daef..f951020 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -149,8 +149,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         try:
             taskdeps = self._build_data(fn, d)
-        except:
+        except Exception as e:
             bb.warn("Error during finalise of %s" % fn)
+            bb.error(str(e))
             raise
 
         #Slow but can be useful for debugging mismatched basehashes
-- 
2.5.0


