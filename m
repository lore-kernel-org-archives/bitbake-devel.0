Return-Path: <andre.draszik@linaro.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id 04DB56B1F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jul 2013 12:56:25 +0000 (UTC)
Received: by mail-bk0-f48.google.com with SMTP id jf20so305584bkc.21
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jul 2013 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:mime-version:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=jE/jmSK87h84SKMeOWhNucer52k3pf7FnKNixAqM/EY=;
	b=oGYoYB3dyP9drAWMBd2gEw3BQofTqll1Z6GPk1wYLAqUqSApCk/EWam98rFqnEjUsM
	SSF2exQ0mryeCseR0kswUnq3AjffMLJYFBu1oSrp6eo4qqRxflFqkuB29GXcJijCvVmi
	dHyJm2qeiJ5kXxmiNR9fJDj4DYSfLTRMJxhF2RVgxestjEh0MQADRaBgGumF8FSdDbwy
	2AZw5gEUhJGHd+Aq5xwGQV+Go419hgAlM+z+EDZHmVRg7spUyPhXD6s4QA2Rv1l0PnJ0
	5W8H8Cu9xkX1fzSIs/xTP6f3F1cpb1NwZIOGKvMhnpL/nd+KtN/E0UhX+48oU4hevtPL
	4y4Q==
X-Received: by 10.204.187.11 with SMTP id cu11mr1343959bkb.161.1375188986028; 
	Tue, 30 Jul 2013 05:56:26 -0700 (PDT)
Received: from bril0118.bri.st.com (sushi.andred.org. [85.214.105.253])
	by mx.google.com with ESMTPSA id ji5sm5778621bkb.10.2013.07.30.05.56.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 30 Jul 2013 05:56:25 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jul 2013 13:56:22 +0100
Message-Id: <1375188982-12532-1-git-send-email-andre.draszik@linaro.org>
X-Mailer: git-send-email 1.8.2
MIME-Version: 1.0
X-Gm-Message-State: ALoCoQmfZkgUsKvGK9vBsxV59gH1UCj4zHJrkygFYuDPbMI+EAbPpwUU10MdBLz9UWwqP6G0iI9r
Subject: [master][PATCH] fetch2: fix unpack of .xz files
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 30 Jul 2013 12:56:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a file ends with .xz, it currently gets overwritten during unpack:
The decompress command for .xz files is:
  'xz -dc %s > %s' % (file, efile)
and as efile == file, we end up overwriting file (the source).

Fix this by adding .xz to the list of suffixes that that need to
be removed from a file name for an extract command, leaving the
bare file name. Now, for a given file foo.xz,
file == foo.xz and efile == foo, similar to how .gz .bz2 and .Z
files are treated.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6211cd7..451d104 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1157,7 +1157,7 @@ class FetchMethod(object):
                      (file, urldata.parm.get('unpack')))
 
         dots = file.split(".")
-        if dots[-1] in ['gz', 'bz2', 'Z']:
+        if dots[-1] in ['gz', 'bz2', 'Z', 'xz']:
             efile = os.path.join(rootdir, os.path.basename('.'.join(dots[0:-1])))
         else:
             efile = file
-- 
1.8.2


