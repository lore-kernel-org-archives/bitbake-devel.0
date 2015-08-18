Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 346AB76A11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:12 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so99775021wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=U7XnPcKWNc+Ava53a2QyFodVVyH+sRYUJUXN1ccCqlY=;
	b=Dx3q4eVTHKylMNYOf/i5kBCv9b0Xu78wrPoYnhmwM7mKEnwmS/LUw/3fn6ulFkZDgz
	zD4F1UeHwzdvHMaq0v85EkbrCb9sWluypk5ajbD3QX8bffAvh9Ww8Vax4v4GuNQC5HFp
	/UAIrWEFdLpQDYI+PoFxEYqSQmlsgXrrm3ZoxN8Un+HP3QyAYCxoNE0SdsPi6clhEfXc
	LEJByLKodawui/u9MbakV+OwAo/AE56gpewZ6vEhtD9dyjODQh6b80LLFd8rey5bw8Yg
	Jpg/vZGMqMhJXjXSSOMdpBWWs97D3afgaC6K6/Z8j5gPz1LIWAqoPnq7JWGfWI7/0svI
	AmHw==
X-Gm-Message-State: ALoCoQkKUyNjPuPRqe7M0d/uUeQsu88EZjLm++yqcD4C1gIV2DLXpcVekv+pjDMXLX0nsDx8p66N
X-Received: by 10.180.75.78 with SMTP id a14mr45521562wiw.43.1439915352306;
	Tue, 18 Aug 2015 09:29:12 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:11 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:54 +0100
Message-Id: <88cda31cdb7f03b4f7b9a42689bae6cd17f70e71.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 08/14] bitbake: toaster: do not stop data import on bad data
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The layer data update in Layer source needlessly stops
processing by throwing an Exception when bad layer data cannot
be inserted in the database (e.g. invalid dependencies).

This patch changes the behaviour to ignore bad data, and
continue with data import after detailed logging through the
logging system.

[YOCTO #7955]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index c3fb766..de00702 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from django.db import models
+from django.db import models, IntegrityError
 from django.db.models import F, Q, Avg, Max
 from django.utils import timezone
 
@@ -938,7 +938,7 @@ class LayerIndexLayerSource(LayerSource):
             try:
                 dependlist[lv].append(Layer_Version.objects.get(layer_source = self, layer__up_id = ldi['dependency'], up_branch = lv.up_branch))
             except Layer_Version.DoesNotExist:
-                logger.warning("Cannot find layer version %s dep:%s up_brach:%s" % (self, ldi['dependency'], lv.up_branch))
+                logger.warning("Cannot find layer version (ls:%s), up_id:%s lv:%s" % (self, ldi['dependency'], lv))
 
         for lv in dependlist:
             LayerVersionDependency.objects.filter(layer_version = lv).delete()
@@ -989,8 +989,8 @@ class LayerIndexLayerSource(LayerSource):
                 if 'inherits' in ri:
                     ro.is_image = 'image' in ri['inherits'].split()
                 ro.save()
-            except Exception:
-                logger.warning("Duplicate Recipe, ignoring: %s " % vars(ro))
+            except IntegrityError as e:
+                logger.debug("Failed saving recipe, ignoring: %s (%s:%s)" % (e, ro.layer_version, ri['filepath']+"/"+ri['filename']))
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
 
-- 
2.1.4


