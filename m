Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA43C433FE
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:46 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.913.1635865066144285304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OwmUEVoQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id
 b2-20020a1c8002000000b0032fb900951eso2177203wmd.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=giWLb/w/Y0It8igkVa+1FOigd+LODjq4dUvFGkSDwNg=;
        b=OwmUEVoQh5e80PnfbmHrR36+XTZP8xrWwUMaCaIrYId2KxDnK5pSYC9vhATPOWZ1IY
         viJa+NwDor5h71T+WTuxy3nyZBstfl3B60APIOFMgoBJjqIKgayqoOO9GsvKF4KnOjWq
         +yuYoN5yc7Yaec2R1nLbf8Bf8DTrGm/nz8BUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=giWLb/w/Y0It8igkVa+1FOigd+LODjq4dUvFGkSDwNg=;
        b=cCGR89YeRNs1DMkB7SMJLc+QzgqDaslwSeycYcjhRcFJUgnUqJBjPqbQ4rGS06EY6B
         epxAqRN6UnahaaiMBT4ifnK/yjEOB1+/AW6khwLfn4BPeOk5aneC7Z3AHPD12lDm3gQi
         slIQ19aJSKf7b2kvCEUSVns95+1LhyUcgBDUxbWO1YFd341QAR7+ckhEJ7wdKCHnJ0YM
         jlpEiauw/w+b1rZG1LXQngilgEU82wORt0VjGc7VsgWuUnz4uCq+8KUTh4ll4uHNXHPo
         ++78wdvRPxTHzTZkODt0Of0KOf3ZQqXatbhXkDUql7h2w3AQNYBC1EpJdKGFaOF29SEe
         tYlg==
X-Gm-Message-State: AOAM530P7y74x9qfAMAYo8K3TKnpcaYrtbu9u4ZLMpsAgiFKxFpWlrTZ
	x2H77USeq5jwDNgOkPgAPS3nRcRqGxpa5Q==
X-Google-Smtp-Source: 
 ABdhPJylh8DREQDw/CqMQSpuXDA+hoMK0xFSjb7WpQffJBvtysl7ibdGJlbUgX2I8Z7vosCvh6hySg==
X-Received: by 2002:a05:600c:4f87:: with SMTP id
 n7mr6003647wmq.63.1635865064166;
        Tue, 02 Nov 2021 07:57:44 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 q26sm14916634wrc.39.2021.11.02.07.57.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:57:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/5] lib/bb: Fix string concatination potential performance
 issues
Date: Tue,  2 Nov 2021 14:57:40 +0000
Message-Id: <20211102145742.3550251-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
References: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12864

Python scales badly when concatinating strings in loops. Most of these
references aren't problematic but at least one (in data.py) is probably
a performance issue as the issue is compounded as strings become large.

The way to handle this in python is to create lists which don't reconstruct
all the objects when appending to them. We may as well fix all the references
since it stops them being copy/pasted into something problematic in the future.

This patch was based on issues highligthted by a report from AWS Codeguru.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py               | 24 +++++++++++------------
 lib/bb/data_smart.py         |  6 +++---
 lib/bb/fetch2/__init__.py    | 16 ++++++++--------
 lib/bb/runqueue.py           | 37 ++++++++++++++++++------------------
 lib/bb/server/process.py     |  6 +++---
 lib/bb/ui/buildinfohelper.py | 16 ++++++++--------
 6 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 9d18b1e2bf..008c5593cf 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -285,21 +285,19 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
         vardeps = varflags.get("vardeps")
 
         def handle_contains(value, contains, d):
-            newvalue = ""
+            newvalue = []
+            if value:
+                newvalue.append(value)
             for k in sorted(contains):
                 l = (d.getVar(k) or "").split()
                 for item in sorted(contains[k]):
                     for word in item.split():
                         if not word in l:
-                            newvalue += "\n%s{%s} = Unset" % (k, item)
+                            newvalue.append("\n%s{%s} = Unset" % (k, item))
                             break
                     else:
-                        newvalue += "\n%s{%s} = Set" % (k, item)
-            if not newvalue:
-                return value
-            if not value:
-                return newvalue
-            return value + newvalue
+                        newvalue.append("\n%s{%s} = Set" % (k, item))
+            return "".join(newvalue)
 
         def handle_remove(value, deps, removes, d):
             for r in sorted(removes):
@@ -406,7 +404,9 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, whitelist, fn):
 
         if data is None:
             bb.error("Task %s from %s seems to be empty?!" % (task, fn))
-            data = ''
+            data = []
+        else:
+            data = [data]
 
         gendeps[task] -= whitelist
         newdeps = gendeps[task]
@@ -424,12 +424,12 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, whitelist, fn):
 
         alldeps = sorted(seen)
         for dep in alldeps:
-            data = data + dep
+            data.append(dep)
             var = lookupcache[dep]
             if var is not None:
-                data = data + str(var)
+                data.append(str(var))
         k = fn + ":" + task
-        basehash[k] = hashlib.sha256(data.encode("utf-8")).hexdigest()
+        basehash[k] = hashlib.sha256("".join(data).encode("utf-8")).hexdigest()
         taskdeps[task] = alldeps
 
     return taskdeps, basehash
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8d235da121..7ed7112bdc 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -810,7 +810,7 @@ class DataSmart(MutableMapping):
                     expanded_removes[r] = self.expand(r).split()
 
                 parser.removes = set()
-                val = ""
+                val = []
                 for v in __whitespace_split__.split(parser.value):
                     skip = False
                     for r in removes:
@@ -819,8 +819,8 @@ class DataSmart(MutableMapping):
                             skip = True
                     if skip:
                         continue
-                    val = val + v
-                parser.value = val
+                    val.append(v)
+                parser.value = "".join(val)
                 if expand:
                     value = parser.value
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1d6e4e0964..43b312ce7e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -402,24 +402,24 @@ def encodeurl(decoded):
 
     if not type:
         raise MissingParameterError('type', "encoded from the data %s" % str(decoded))
-    url = '%s://' % type
+    url = ['%s://' % type]
     if user and type != "file":
-        url += "%s" % user
+        url.append("%s" % user)
         if pswd:
-            url += ":%s" % pswd
-        url += "@"
+            url.append(":%s" % pswd)
+        url.append("@")
     if host and type != "file":
-        url += "%s" % host
+        url.append("%s" % host)
     if path:
         # Standardise path to ensure comparisons work
         while '//' in path:
             path = path.replace("//", "/")
-        url += "%s" % urllib.parse.quote(path)
+        url.append("%s" % urllib.parse.quote(path))
     if p:
         for parm in p:
-            url += ";%s=%s" % (parm, p[parm])
+            url.append(";%s=%s" % (parm, p[parm]))
 
-    return url
+    return "".join(url)
 
 def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     if not ud.url or not uri_find or not uri_replace:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 87c00462c1..67f8dfbd9e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1061,12 +1061,12 @@ class RunQueueData:
                         seen_pn.append(pn)
                     else:
                         bb.fatal("Multiple versions of %s are due to be built (%s). Only one version of a given PN should be built in any given build. You likely need to set PREFERRED_VERSION_%s to select the correct version or don't depend on multiple versions." % (pn, " ".join(prov_list[prov]), pn))
-                msg = "Multiple .bb files are due to be built which each provide %s:\n  %s" % (prov, "\n  ".join(prov_list[prov]))
+                msgs = ["Multiple .bb files are due to be built which each provide %s:\n  %s" % (prov, "\n  ".join(prov_list[prov]))]
                 #
                 # Construct a list of things which uniquely depend on each provider
                 # since this may help the user figure out which dependency is triggering this warning
                 #
-                msg += "\nA list of tasks depending on these providers is shown and may help explain where the dependency comes from."
+                msg.append("\nA list of tasks depending on these providers is shown and may help explain where the dependency comes from.")
                 deplist = {}
                 commondeps = None
                 for provfn in prov_list[prov]:
@@ -1086,12 +1086,12 @@ class RunQueueData:
                         commondeps &= deps
                     deplist[provfn] = deps
                 for provfn in deplist:
-                    msg += "\n%s has unique dependees:\n  %s" % (provfn, "\n  ".join(deplist[provfn] - commondeps))
+                    msg.append("\n%s has unique dependees:\n  %s" % (provfn, "\n  ".join(deplist[provfn] - commondeps)))
                 #
                 # Construct a list of provides and runtime providers for each recipe
                 # (rprovides has to cover RPROVIDES, PACKAGES, PACKAGES_DYNAMIC)
                 #
-                msg += "\nIt could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful."
+                msg.append("\nIt could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful.")
                 provide_results = {}
                 rprovide_results = {}
                 commonprovs = None
@@ -1118,16 +1118,16 @@ class RunQueueData:
                     else:
                         commonrprovs &= rprovides
                     rprovide_results[provfn] = rprovides
-                #msg += "\nCommon provides:\n  %s" % ("\n  ".join(commonprovs))
-                #msg += "\nCommon rprovides:\n  %s" % ("\n  ".join(commonrprovs))
+                #msg.append("\nCommon provides:\n  %s" % ("\n  ".join(commonprovs)))
+                #msg.append("\nCommon rprovides:\n  %s" % ("\n  ".join(commonrprovs)))
                 for provfn in prov_list[prov]:
-                    msg += "\n%s has unique provides:\n  %s" % (provfn, "\n  ".join(provide_results[provfn] - commonprovs))
-                    msg += "\n%s has unique rprovides:\n  %s" % (provfn, "\n  ".join(rprovide_results[provfn] - commonrprovs))
+                    msg.append("\n%s has unique provides:\n  %s" % (provfn, "\n  ".join(provide_results[provfn] - commonprovs)))
+                    msg.append("\n%s has unique rprovides:\n  %s" % (provfn, "\n  ".join(rprovide_results[provfn] - commonrprovs)))
 
                 if self.warn_multi_bb:
-                    logger.verbnote(msg)
+                    logger.verbnote("".join(msg))
                 else:
-                    logger.error(msg)
+                    logger.error("".join(msg))
 
         self.init_progress_reporter.next_stage()
 
@@ -1935,7 +1935,7 @@ class RunQueueExecute:
         self.stats.taskFailed()
         self.failed_tids.append(task)
 
-        fakeroot_log = ""
+        fakeroot_log = []
         if fakerootlog and os.path.exists(fakerootlog):
             with open(fakerootlog) as fakeroot_log_file:
                 fakeroot_failed = False
@@ -1945,12 +1945,12 @@ class RunQueueExecute:
                             fakeroot_failed = True
                     if 'doing new pid setup and server start' in line:
                         break
-                    fakeroot_log = line + fakeroot_log
+                    fakeroot_log.append(line)
 
             if not fakeroot_failed:
-                fakeroot_log = None
+                fakeroot_log = []
 
-        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq, fakeroot_log=fakeroot_log), self.cfgData)
+        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq, fakeroot_log=("".join(fakeroot_log) or None)), self.cfgData)
 
         if self.rqdata.taskData[''].abort:
             self.rq.state = runQueueCleanUp
@@ -2608,12 +2608,13 @@ class RunQueueExecute:
         pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
         if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
             if tid in self.rqdata.runq_setscene_tids:
-                msg = 'Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname)
+                msg = ['Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname)]
             else:
-                msg = 'Task %s.%s attempted to execute unexpectedly' % (pn, taskname)
+                msg = ['Task %s.%s attempted to execute unexpectedly' % (pn, taskname)]
             for t in self.scenequeue_notcovered:
-                msg = msg + "\nTask %s, unihash %s, taskhash %s" % (t, self.rqdata.runtaskentries[t].unihash, self.rqdata.runtaskentries[t].hash)
-            logger.error(msg + '\nThis is usually due to missing setscene tasks. Those missing in this build were: %s' % pprint.pformat(self.scenequeue_notcovered))
+                msg.append("\nTask %s, unihash %s, taskhash %s" % (t, self.rqdata.runtaskentries[t].unihash, self.rqdata.runtaskentries[t].hash))
+            msg.append('\nThis is usually due to missing setscene tasks. Those missing in this build were: %s' % pprint.pformat(self.scenequeue_notcovered))
+            logger.error("".join(msg))
             return True
         return False
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 8fdcc66dc7..1636616660 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -326,10 +326,10 @@ class ProcessServer():
                         if e.errno != errno.ENOENT:
                             raise
 
-                msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
+                msg = ["Delaying shutdown due to active processes which appear to be holding bitbake.lock"]
                 if procs:
-                    msg += ":\n%s" % str(procs.decode("utf-8"))
-                serverlog(msg)
+                    msg.append(":\n%s" % str(procs.decode("utf-8")))
+                serverlog("".join(msg))
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8588849dd4..835e92c299 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -571,7 +571,7 @@ class ORMWrapper(object):
         assert isinstance(build_obj, Build)
         assert isinstance(target_obj, Target)
 
-        errormsg = ""
+        errormsg = []
         for p in packagedict:
             # Search name swtiches round the installed name vs package name
             # by default installed name == package name
@@ -636,7 +636,7 @@ class ORMWrapper(object):
                     if packagefile_objects:
                         Package_File.objects.bulk_create(packagefile_objects)
                 except KeyError as e:
-                    errormsg += "  stpi: Key error, package %s key %s \n" % ( p, e )
+                    errormsg.append("  stpi: Key error, package %s key %s \n" % (p, e))
 
             # save disk installed size
             packagedict[p]['object'].installed_size = packagedict[p]['size']
@@ -678,8 +678,8 @@ class ORMWrapper(object):
         else:
             logger.info("No package dependencies created")
 
-        if len(errormsg) > 0:
-            logger.warning("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)
+        if errormsg:
+            logger.warning("buildinfohelper: target_package_info could not identify recipes: \n%s", "".join(errormsg))
 
     def save_target_image_file_information(self, target_obj, file_name, file_size):
         Target_Image_File.objects.create(target=target_obj,
@@ -1404,7 +1404,7 @@ class BuildInfoHelper(object):
         assert 'pn' in event._depgraph
         assert 'tdepends' in event._depgraph
 
-        errormsg = ""
+        errormsg = []
 
         # save layer version priorities
         if 'layer-priorities' in event._depgraph.keys():
@@ -1496,7 +1496,7 @@ class BuildInfoHelper(object):
                 elif dep in self.internal_state['recipes']:
                     dependency = self.internal_state['recipes'][dep]
                 else:
-                    errormsg += "  stpd: KeyError saving recipe dependency for %s, %s \n" % (recipe, dep)
+                    errormsg.append("  stpd: KeyError saving recipe dependency for %s, %s \n" % (recipe, dep))
                     continue
                 recipe_dep = Recipe_Dependency(recipe=target,
                                                depends_on=dependency,
@@ -1537,8 +1537,8 @@ class BuildInfoHelper(object):
                 taskdeps_objects.append(Task_Dependency( task = target, depends_on = dep ))
         Task_Dependency.objects.bulk_create(taskdeps_objects)
 
-        if len(errormsg) > 0:
-            logger.warning("buildinfohelper: dependency info not identify recipes: \n%s", errormsg)
+        if errormsg:
+            logger.warning("buildinfohelper: dependency info not identify recipes: \n%s", "".join(errormsg))
 
 
     def store_build_package_information(self, event):
-- 
2.32.0


