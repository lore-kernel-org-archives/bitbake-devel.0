Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 9E50A76A2D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:07 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so105264395wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yrjyYBdsSCtrs1sTiyJaN+Wdbhddy6Q1skcz9rajb5o=;
	b=kKEcd0ufpJERpYbEiXk3vQERBadthcqS2NgOpgtAGc5YLti0Q6SQnuAmcspOTti3aY
	3G3mOKaRbOREPx8eiiT6P25I3q8yT9Y2IdfqTlCSzYtnJ4dh3g1FFnMft7jLqqTXXdVE
	1UDC/9R+uzGH2sOh64BTiymOcMETXuebB542yWPWwsAcNxjrlFb9O+DTo0JL3fkLdGIJ
	U5KJTTL6uQ0EHC0nzPgdjt3vo03OJyegnR4hQYUJHLPbsa7erWUhrh+0ATbaXrWQey2k
	TXi51PEbHyEeuUdYMglRfiePlL7jdsWYeJTkRExp5gIcozAzwfq1GBJLDkxLsXhXug/j
	rdLw==
X-Gm-Message-State: ALoCoQkki+W/VmZG8GSY6VuYeRRqVGTYl51veFNsEKAbPI13gPpl8HeUNmgONEbdwUD6CgW1gB5P
X-Received: by 10.180.211.98 with SMTP id nb2mr45238014wic.91.1439915347660;
	Tue, 18 Aug 2015 09:29:07 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:07 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:50 +0100
Message-Id: <2e16e31edf84a3fa54cf12025625853a39b4ce70.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 04/14] bitbake: toaster: improve exception handling
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch improves exception handling, fixing issues
as prompted by pylint, including exception renaming.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py       | 15 ++++++---------
 lib/toaster/toastergui/views.py | 13 ++++---------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b3f8db9..6b485d2 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -269,11 +269,10 @@ class Project(models.Model):
             except ProjectVariable.DoesNotExist:
                 pass
             br.save()
-        except Exception as e:
+        except Exception:
+            # revert the build request creation since we're not done cleanly
             br.delete()
-            import sys
-            et, ei, tb = sys.exc_info()
-            raise type(e), e, tb
+            raise
         return br
 
 class Build(models.Model):
@@ -364,7 +363,7 @@ class BuildArtifact(models.Model):
 
 
     def is_available(self):
-        return build.buildrequest.environment.has_artifact(file_path)
+        return self.build.buildrequest.environment.has_artifact(self.file_name)
 
 class ProjectTarget(models.Model):
     project = models.ForeignKey(Project)
@@ -981,12 +980,10 @@ class LayerIndexLayerSource(LayerSource):
                 if 'inherits' in ri:
                     ro.is_image = 'image' in ri['inherits'].split()
                 ro.save()
-            except:
-                #print "Duplicate Recipe, ignoring: ", vars(ro)
-                pass
+            except Exception:
+                logger.warning("Duplicate Recipe, ignoring: %s " % vars(ro))
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
-        pass
 
 class BitbakeVersion(models.Model):
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7be7f71..5cee068 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1876,10 +1876,7 @@ if True:
 
         queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
 
-        try:
-            context, pagesize, orderby = _build_list_helper(request, queryset)
-        except InvalidRequestException as e:
-            raise RedirectException( builds, request.GET, e.response)
+        context, pagesize, orderby = _build_list_helper(request, queryset)
 
         _set_parameters_values(pagesize, orderby, request)
         return context
@@ -2422,7 +2419,8 @@ if True:
                         # dependency already (like modified on another page)
                         try:
                             prj_layer, prj_layer_created = ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj)
-                        except:
+                        except IntegrityError as e:
+                            logger.warning("Integrity error while saving Project Layers: %s (original %s)" % (e, e.__cause__))
                             continue
 
                         if prj_layer_created:
@@ -2639,10 +2637,7 @@ if True:
 
         queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
 
-        try:
-            context, pagesize, orderby = _build_list_helper(request, queryset)
-        except InvalidRequestException as e:
-            raise RedirectException('projectbuilds', request.GET, e.response, pid = pid)
+        context, pagesize, orderby = _build_list_helper(request, queryset)
 
         context['project'] = prj
         _set_parameters_values(pagesize, orderby, request)
-- 
2.1.4


