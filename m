Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 91F9A770C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:33 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so112575702pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=GUFezxzkYLjy2xJZ6r5bzBlQ+BwQogmKCpzUjx5wWek=;
	b=gqYTW4q34eMOl5NkPNEG+zl0n7P9bAwKw+Mui/eohqwTv9x85Cn2keRIPuiSLV20WO
	SyyC/vOaL4lroTIN/M4ASE8baMdN6adqVMe0cmni2hK42I+98/vZ8voEz6jch0vKvrNT
	RJ1WC1LeZ+BQvXx+fIAmxR6tX+99cI3wupBLOVf8RvK+K+IZ5njq6LS5ce3IcKjvTu8R
	FR24Q1aOzrzB83uCdN0faNBb9dVwt/hqRUSU0cOHuo/MLu1Ht4ga9POKGEDP8eqVhzqD
	PCti+Ctbpz4z3CYQYsCNFeuCJM0xOT/YwF5Ok3C/WJ+SvlGp+qLf1IJLi5m/45xnrPbF
	WizA==
X-Received: by 10.66.252.131 with SMTP id zs3mr21140972pac.75.1443809014480;
	Fri, 02 Oct 2015 11:03:34 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw10sm13142211pbc.25.2015.10.02.11.03.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:32 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:13 -0700
Message-Id: <5db7a698cf35481a0bb5e62867e2bca10a14ed0e.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
References: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443809021.git.avery.brian@gmail.com>
References: <cover.1443809021.git.avery.brian@gmail.com>
Subject: [PATCH 2/5] toaster: use get_alldeps in layerdetails renderer
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:34 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used Layer_Version.get_alldeps api in layerdetails template
renderer to get list of layer dependencies.

[YOCTO 8004]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9f16e8f..3168cfa 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2760,8 +2760,8 @@ if True:
 
         context = { 'project' : project,
                    'layerversion' : layer_version,
-                   'layerdeps' : { "list": [
-                     [{"id": y.id, "name": y.layer.name} for y in x.depends_on.get_equivalents_wpriority(project)][0] for x in layer_version.dependencies.all()]},
+                   'layerdeps' : {"list": [{"id": dep.id, "name": dep.layer.name} \
+                                              for dep in layer_version.get_alldeps(project.id)]},
                    'projectlayers': map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
                   }
 
-- 
1.9.1


