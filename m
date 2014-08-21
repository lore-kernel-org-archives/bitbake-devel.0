Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BA82270F28
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 20:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKnjSp021895 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:49:45 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l31jlGOHF3wM for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:49:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKngMD021892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:49:43 +0100
Message-ID: <1408654183.1669.121.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Aug 2014 21:49:43 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [Fwd: [OE-core] [PATCH] bitbake-worker: Improve sigterm handler]
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
X-List-Received-Date: Thu, 21 Aug 2014 20:49:46 -0000
X-Groupsio-MsgNum: 4986
Content-Type: multipart/mixed; boundary="=-LDYiDv+pFzc7rzz6JRj/"

--=-LDYiDv+pFzc7rzz6JRj/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-LDYiDv+pFzc7rzz6JRj/
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [OE-core]
 [PATCH] bitbake-worker: Improve sigterm handler
Content-Type: message/rfc822

Return-Path: <richard.purdie+caf_=rpurdie=rpsys.net@linuxfoundation.org>
Received: from localhost (localhost [127.0.0.1]) by dan.rpsys.net
 (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s7LKlq1x021742 for
 <rpurdie@[127.0.0.1]>; Thu, 21 Aug 2014 21:48:15 +0100
Received: from dan.rpsys.net ([127.0.0.1]) by localhost (dan.rpsys.net
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id 4aJe0zkFDv49 for
 <rpurdie@[127.0.0.1]>; Thu, 21 Aug 2014 21:48:15 +0100 (BST)
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44]) by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with
 ESMTP id s7LKmBdc021771 (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128
 verify=NOT) for <rpurdie@rpsys.net>; Thu, 21 Aug 2014 21:48:12 +0100
Received: by mail-la0-f44.google.com with SMTP id el20so9368951lab.3 for
 <rpurdie@rpsys.net>; Thu, 21 Aug 2014 13:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net;
 s=20130820;
 h=x-original-authentication-results:x-gm-message-state:delivered-to
 :delivered-to:message-id:from:to:date:mime-version:subject
 :precedence:list-id:list-unsubscribe:list-archive:list-post
 :list-help:list-subscribe:content-type:content-transfer-encoding
 :sender:errors-to; bh=YSvw57DfFbcqLKieca11mIeCK0TVi+yGNjdLcFRrd4k=;
 b=Yik7+DizG636vHJSsuKP08zFKuI/QhPCQXvtpDnUCwE7unFGhY2Y9vMXYIcjNiUHfW
 +j0xx+saYU1mgGF5nGcJ1h5AEOcvH/Vg09HvA//u7VS58apHpDnLIiLwRIsHUSKk4f8F
 +lRxX47fE3ErtnPV78xT6J1eXTLNMwmCasRFPoChcQNjj3xcitmbYqJq/J292BjATPmW
 TvzY1LPVt46j1C2igZPPKinrSIZVDJQ/Nz2npVM2IIezY1jDjgFm//XblVCghP7dekG/
 JzThz9zbuLi8+pJRXPpanM2QUyq4LFAcCzQCIWCBOxhSO0+cxhYa/5a59Ql4EylLAT1I mhcg==
X-Original-Authentication-Results: mx.google.com;       spf=neutral
 (google.com: openembedded-core-bounces@lists.openembedded.org does not
 designate permitted sender hosts)
 smtp.mail=openembedded-core-bounces@lists.openembedded.org
X-Gm-Message-State:  ALoCoQmi+Fy5afNJKgizvYqDz7i2CkD7dtC/6e04xiJzmgoV+NkFgDaD3A0oQXeHoZ+4NZGO/Nd0
X-Received: by 10.152.163.199 with SMTP id yk7mr682270lab.85.1408654085469;
 Thu, 21 Aug 2014 13:48:05 -0700 (PDT)
X-Forwarded-To: rpurdie@rpsys.net
X-Forwarded-For: richard.purdie@linuxfoundation.org rpurdie@rpsys.net
Delivered-To: richard.purdie@linuxfoundation.org
Received: by 10.112.15.76 with SMTP id v12csp767854lbc; Thu, 21 Aug 2014
 13:48:04 -0700 (PDT)
X-Received: by 10.68.241.138 with SMTP id
 wi10mr1173247pbc.126.1408654082936; Thu, 21 Aug 2014 13:48:02 -0700 (PDT)
Received: from mail.openembedded.org (mail.openembedded.org.
 [140.211.169.62]) by mx.google.com with ESMTP id
 ck8si38004600pad.215.2014.08.21.13.48.01 for
 <richard.purdie@linuxfoundation.org>; Thu, 21 Aug 2014 13:48:02 -0700 (PDT)
Received-SPF: none (google.com:
 openembedded-core-bounces@lists.openembedded.org does not designate
 permitted sender hosts) client-ip=140.211.169.62;
Authentication-Results: mx.google.com; spf=neutral (google.com:
 openembedded-core-bounces@lists.openembedded.org does not designate
 permitted sender hosts)
 smtp.mail=openembedded-core-bounces@lists.openembedded.org
Received: from mail.openembedded.org (localhost [127.0.0.1]) by
 mail.openembedded.org (Postfix) with ESMTP id 9A50F70F31; Thu, 21 Aug 2014
 20:47:41 +0000 (UTC)
X-Original-To: openembedded-core@lists.openembedded.org
Delivered-To: openembedded-core@lists.openembedded.org
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161]) by
 mail.openembedded.org (Postfix) with ESMTP id 32AE670F24 for
 <openembedded-core@lists.openembedded.org>; Thu, 21 Aug 2014 20:47:01 +0000
 (UTC)
Received: from localhost (localhost [127.0.0.1]) by dan.rpsys.net
 (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s7LKl0mW021671 for
 <openembedded-core@lists.openembedded.org>; Thu, 21 Aug 2014 21:47:00 +0100
Received: from dan.rpsys.net ([127.0.0.1]) by localhost (dan.rpsys.net
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id KDxE7NRNXU9G for
 <openembedded-core@lists.openembedded.org>; Thu, 21 Aug 2014 21:47:00 +0100
 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0) by
 dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
 s7LKkuZJ021666 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128
 verify=NOT) for <openembedded-core@lists.openembedded.org>; Thu, 21 Aug
 2014 21:46:57 +0100
Message-ID: <1408654017.1669.117.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-core <openembedded-core@lists.openembedded.org>
Date: Thu, 21 Aug 2014 21:46:57 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [OE-core] [PATCH] bitbake-worker: Improve sigterm handler
X-BeenThere: openembedded-core@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussions about the oe-core layer
 <openembedded-core.lists.openembedded.org>
List-Unsubscribe:  <http://lists.openembedded.org/mailman/options/openembedded-core>,
 <mailto:openembedded-core-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core@lists.openembedded.org>
List-Help:  <mailto:openembedded-core-request@lists.openembedded.org?subject=help>
List-Subscribe:  <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
 <mailto:openembedded-core-request@lists.openembedded.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: openembedded-core-bounces@lists.openembedded.org
Errors-To: openembedded-core-bounces@lists.openembedded.org
Content-Transfer-Encoding: 7bit

When processes terminate, we really want all of the child processes to
terminate too. This was not happening for worker processes which spawned their
own multiprocessing pools, leading to build hangs. This change ensures any
sigterm gets passed to the whole process group. In local tests, this resolved
some hanging process workloads I could generate. It does rely on signals
being delivered in a timely fashion and there is a multiprocessing bug we have
to work around there.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 05e0cf6..d1ff5b3 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -81,6 +81,11 @@ def workerlog_write(msg):
         lf.write(msg)
         lf.flush()
 
+def sigterm_handler(signum, frame):
+    signal.signal(signal.SIGTERM, signal.SIG_DFL)
+    os.killpg(0, signal.SIGTERM)
+    sys.exit()
+
 def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdata, quieterrors=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
@@ -132,7 +137,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             global worker_pipe
             pipein.close()
 
-            signal.signal(signal.SIGTERM, signal.SIG_DFL)
+            signal.signal(signal.SIGTERM, sigterm_handler)
 
             # Save out the PID so that the event can include it the
             # events


-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--=-LDYiDv+pFzc7rzz6JRj/--
