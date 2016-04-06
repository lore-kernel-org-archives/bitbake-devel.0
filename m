Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id E45317710D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:36 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id n3so71354812wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=3Kn2Y94mZ7e2WzD51yNsFc3D1l4TuGOBmqo9/eQz+Vg=;
	b=zn6zNQU2L0/wBYpV6V0/wVoRaIwPYDrQDhDd4bPvKz/t+6fcDPnso4YiINQBE4MeWq
	aaeq2NQ8/228da5BWk97MvPC2Gv+wetOlxAeA1SwDQ5w0+wIN0nqjxPhhymdV7BR6is8
	+T/Lh+Z0+iYEeUeRCZRgOs2LHE5CJaG0iy+TkAo2VYu25pliZAmfB9YF41HV0EP5mbkq
	lcA9sCysU6RtMwyH5775Y44q1h7S5D91YeWzi5eR4E4G+AvJ4UMfFhj9/4t5axwTGClI
	d1GM/6+59/StoDFcD4xvKN2X+3b5S2Z9ZVW0kK2cE9XX96xVW0YpxzFCSK2+nHPp2xwg
	EpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3Kn2Y94mZ7e2WzD51yNsFc3D1l4TuGOBmqo9/eQz+Vg=;
	b=KDmjTiZonf/eVzx6+d9u3UiO+akllyeZKJuc7/kWgdRFLxHL27GaHQV9CeO0gU7V4X
	kvvTcLX36CNH50BUoOP9HNhFgfP5VCKf7iVbGKrQ3TXjp2HVtgUF+74c8l+6JVYTMXa1
	fFBrQjw5lBWOlTqACD+lM9B/84aioTU4s+Ew2J31SL4lAUFjHb4YctYi1HkeaufW9Jtn
	c8gvgKoxUhfKXPOxlARGHZJT9n3PTY1s8Sh8MAluS1JnmCzEuXVskOk8QeCPvC2fMcfd
	F9kAZCAY4efp7mhrlWWGGtb0/RMbEQyMXg6+XPV84zmkBWRD6FLUxuLsxZ4PD0xm2g2T
	9HiA==
X-Gm-Message-State: AD7BkJIddqQKPGDMucU2jFdZgj3sOAmePmtLTlvZ+yOvje5/iaWglqBG1mhOnz4YI1STlgLy
X-Received: by 10.194.95.40 with SMTP id dh8mr33127627wjb.146.1459961257216;
	Wed, 06 Apr 2016 09:47:37 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:36 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:42 +0100
Message-Id: <ef670582ebf72c48300c669fd9a341e3ff1c19e7.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 32/38] toaster: use empty token
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:37 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

If client xmlrpc token is not provided in the command line, bitbake
generates random token. Server token in --server-only mode is always
empty. This doesn't allow clients with non-empty tokens to connect
to the server. Specifying empty token should stop generation of
random token and make it possible for clients to communicate with
the server.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index d23634f..ab9cf25 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -321,7 +321,7 @@ class LocalhostBEController(BuildEnvironmentController):
         # run build with local bitbake. stop the server after the build.
         log = os.path.join(builddir, 'toaster_ui.log')
         self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
-                        '../bitbake/bin/bitbake %s -u toasterui >>%s 2>&1;'
+                        '../bitbake/bin/bitbake %s -u toasterui --token="" >>%s 2>&1;'
                         'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
                         % (brbe, bbtargets, log, bitbake)], builddir,
                         nowait=True)
-- 
2.1.4


