Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 4945A77117
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:21 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id n3so71346451wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=nL6GZF2zIYQGhQ+2EDYmrnyGInlasXBakVTw8u9Y4go=;
	b=Gk2D4UfuPK/gV8BY/8RMgZCRx8ciVp2wG5By5O20ly/7htDZWbKxEVswfDTnAu+sMU
	BZxGNzOKTSrNyTisjTlHFRePk1pZnJvsk9voqt4ovq49sVRD7nn/gnWHxqibJ+HmoQck
	Ni22DnVr/NHV8YGVH4EkKIbyLyeZoy7Nb8Vct5BhrTuXf20eFdDaIYS8hYfJBv1cXAmR
	SrMOLrLq0DyW/lKr1ZbOYwuyox0hB/54AoXp8pIjKUEOQ8CfulyQuVCKqPZmjePl1kQx
	y1PwJQr/4gvKCQ/Ub/nmED9va04N0dOOTnyRguCxKG28rvtanD0O8aNzaoaOk7gTKqDb
	5QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nL6GZF2zIYQGhQ+2EDYmrnyGInlasXBakVTw8u9Y4go=;
	b=Q1o2Wcse64I/DiDIN0kBdnLEq4d3dvA4m54qQYSsz/tpNHfRlAs1E5Tk2SC+XKsR/o
	ps6xH6gcDxvXZX3MR3eQnzHqSdBERoFylYMG23gEl4A4JC6P+gNLVSkeZcYtSmykrrZe
	I3EYA6xZcvRsniYRucif0iH0KouHHf1trgKAWg/SF0p8SI1sNNTBeiM8ySn1dWHi4ylX
	yNomXRl5iS5zCmJQwdi3mnH4KxjOsdSDoJn3aTeGcpIJvBbG9VkSXOTIgXXNN4DBAWOm
	ftzWngcGU//dWuxcMolBJ33l8HAIpkdS+GMGV9D+tU7UtyXjbP6SQGbe4X7bAvCX4/5A
	waKw==
X-Gm-Message-State: AD7BkJK8qbhgtD6yrPuKagiuTC/F9UOnjeUdUnGnfLqL5gAD7GvxHWF7EbtNjnI7RXa92YNX
X-Received: by 10.28.6.140 with SMTP id 134mr11635275wmg.23.1459961242449;
	Wed, 06 Apr 2016 09:47:22 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:21 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:25 +0100
Message-Id: <6f9f9f6f906f78dc51b693b93c6ef7e835365b0c.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 15/38] toaster: update conf/local.conf
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:22 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added 'INHERIT+="toaster buildhistory"' line to the conf/local conf
when Toaster starts. It should make commandline builds to provide
all required information to Toaster backend.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 5cc77ed..dfaff2e 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -252,9 +252,9 @@ case $CMD in
         fi
 
         # Create configuration file
-        conf=${BUILDDIR}/conf/toaster.conf
-        echo "# Created by toaster start script" > $conf
-        echo "INHERIT+=\"toaster buildhistory\"" >> $conf
+        conf=${BUILDDIR}/conf/local.conf
+        line='INHERIT+="toaster buildhistory"'
+        grep -q "$line" $conf || echo $line >> $conf
 
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
-- 
2.1.4


