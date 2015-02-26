Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1588760670
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:13 +0000 (UTC)
Received: by wghn12 with SMTP id n12so15141898wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IZ93/uUz61RqTtX8/nYqHA1kzPDc2tWpkC3AOVYwX0A=;
	b=NoWgH0ggwjdW+YYIr45/zQys1CNHu4UMq1kVgXCtnULzZHBYR3Pa+fOPiY/a9rv/Ot
	r/DqdyY6IKoXBJZp++IArFoBZVUFBFpOwN/yHM/5w4mot2n9DKNcUVvQewGr7ahuRaFg
	mbJndLG2eBfIAhQRe1a7VTZBvtCyLiV2hn6cikT9LG5lMpUw/lFTlxqDMnMBGionjeKo
	KwOKh3qTftjQfVl3J5Kfs5RNUYs73uO65CIByt7Y0tlmfoWFGnbhZDIqNEFAAooNd5hW
	GG8KVj08LYKXGP/BUXX5sn6eLglh3LPXeLNHcbWamhPhC2DUTINm9iBKs0o1II4qbuel
	t6ww==
X-Gm-Message-State: ALoCoQnm/qhos1FYiUXclGgeSbxYq+hKAuIocXgoSYtn5zSN+X0ZvwcElIOHcfPFjfuNkldmgRaw
X-Received: by 10.180.85.39 with SMTP id e7mr124950wiz.90.1424986934488;
	Thu, 26 Feb 2015 13:42:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n6sm3192647wjy.8.2015.02.26.13.42.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:12 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BEEB856140B; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:55 +0000
Message-Id: <0f4a31422a466a52bfe2f833c4ed3c71ad7540de.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 2/8] toastergui: stop covered task graph traversal early
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch stops the breadth-frist graph traversal for
finding covering tasks after the finding the first level
of executed tasks.

The reasoning is that the first level of executed tasks is the
actually relevent information on how a task was covered.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index aabc3d0..a206f80 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -357,6 +357,8 @@ def generateCoveredList2( revlist = [] ):
     covered_list =  [ x for x in revlist if x.outcome == Task.OUTCOME_COVERED ]
     while len(covered_list):
         revlist =  [ x for x in revlist if x.outcome != Task.OUTCOME_COVERED ]
+        if len(revlist) > 0:
+            return revlist
 
         newlist = _find_task_revdep_list(covered_list)
 
@@ -379,10 +381,7 @@ def task( request, build_id, task_id ):
     coveredBy = '';
     if ( task.outcome == Task.OUTCOME_COVERED ):
 #        _list = generateCoveredList( task )
-        _list = generateCoveredList2( _find_task_revdep( task ) )
-        coveredBy = [ ]
-        for t in _list:
-            coveredBy.append( t )
+        coveredBy = sorted(generateCoveredList2( _find_task_revdep( task ) ), key = lambda x: x.recipe.name)
     log_head = ''
     log_body = ''
     if task.outcome == task.OUTCOME_FAILED:
-- 
1.9.1


