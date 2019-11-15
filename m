Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 833EA7C446
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 18:08:11 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id b3so11933119wrs.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=O5KgPOJSjjGIt+IrGaBz2OQMsGQnka5YjhGLrCOmq3Q=;
	b=JhvbG3KoLX1vDXGFcgUrs3wFxwoVlyyOoZfhkt06Guhb3CJEgos/zTahr/wpLr6NOg
	p/JqF7lMcoHn/xuQa0pPHWLi3UBjpELfgUxEiWDueAFfjv5FFXDhiNI7NKr6x8bQck4J
	h2zvZZYRAzIcY/jU+hT45fPZEIr9UXIVf+Xf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=O5KgPOJSjjGIt+IrGaBz2OQMsGQnka5YjhGLrCOmq3Q=;
	b=r+1atcYyEyygDezt6pFQ3gSiqLmHSVHVuj1wWzU7nA67JG2R0brNIN5lAy0Zus4CHB
	K59zg9PIe6AHpupUyC1H36WGgr1gReXEUsTKG1X0/iwvWUyNlClgl6zURf76SRjJxIZN
	xwJKmJYkTmJvQTJRNqiRz52LQC7flOEACdp9xgtnH+yFV1/WVr96Bk/JR4xpo7uDdTmk
	1jGSJOcQFqk/nzoqiFpM2qADCDEX++4U3ebqsjd6eS8Hz7LWPLJIwRh9fKar4m4+bnj8
	R+EniOR0R+qZyEX/9VsyX5tSHYUPcKbEAmFs59g8UVz4Z5GI2k5mbOY3e8WYmuVG1jMb
	NHuw==
X-Gm-Message-State: APjAAAX57kl3d3wpsDZlWbge5Guq0FykPuSf2pKmwrpmWoqWWxljNsns
	LzR4EMeTA3EtjOInx4G164lSLlh/vmE=
X-Google-Smtp-Source: APXvYqzNg20FtN0DIU+R7CNyA2na0hySUJCVvIzBf+UmuZlDtpypn1yvwpZ2I9O3cAMrH40zSoXU7g==
X-Received: by 2002:a5d:6b4d:: with SMTP id x13mr15842361wrw.96.1573841291609; 
	Fri, 15 Nov 2019 10:08:11 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	11sm11360534wmb.34.2019.11.15.10.08.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 15 Nov 2019 10:08:11 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Nov 2019 18:08:10 +0000
Message-Id: <20191115180810.14392-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] fetch2/clearcase: Fix warnings from python 3.8
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
X-List-Received-Date: Fri, 15 Nov 2019 18:08:11 -0000
Content-Transfer-Encoding: 8bit

bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is" with a literal. Did you mean "=="?
      if command is 'mkview':
bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'rmview':
bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'setcs':

Python 3.8 is quite correct and we so mean "==" here, fix it to
avoid the warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/clearcase.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3dd93ad6b1..e2934ef9fc 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -145,18 +145,18 @@ class ClearCase(FetchMethod):
 
         basecmd = "%s %s" % (ud.basecmd, command)
 
-        if command is 'mkview':
+        if command == 'mkview':
             if not "rcleartool" in ud.basecmd:
                 # Cleartool needs a -snapshot view
                 options.append("-snapshot")
             options.append("-tag %s" % ud.viewname)
             options.append(ud.viewdir)
 
-        elif command is 'rmview':
+        elif command == 'rmview':
             options.append("-force")
             options.append("%s" % ud.viewdir)
 
-        elif command is 'setcs':
+        elif command == 'setcs':
             options.append("-overwrite")
             options.append(ud.configspecfile)
 
-- 
2.20.1


