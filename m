Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id E22BA7F366
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 13:43:44 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id y23so16159690ljn.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jHfBMQ9yyfWKsbsljDRNz01ixbzhQct7jNvNy6hqgkM=;
	b=KUr1rTY4klE5mMMGwbW/eF3ybnTUxvTS7B9sC02L17NboswWJASKiUpkEfhEWaT+fw
	bzY4OreSprGFoc30Z3pIg7XfJKZXKBrwZBCr3I1E0mCG3f9fEu03xBMQb8Nj4VbCcz72
	QFbBmnVGvEQl+d22bM8zD7Y8WOijdSG74a9tBFFPrQxKSuhnDh4Ts6mTBNhCiUbxkdNz
	LgctBL1ZFMgh5jSrF1v8O7IjUwG+Q9LxEM3kAiIU7V9VedaB6uCfZX5Ni8ItWvcrvj4/
	tZ5YFc9iS+QQmbiO1bNY1wg8NghJgCkvr2bf4gBac8bSvnquWJ5Wh+lZVd6uWaMoUmrF
	2jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jHfBMQ9yyfWKsbsljDRNz01ixbzhQct7jNvNy6hqgkM=;
	b=KbO8+FSIOpZBjmbkgkAMhTf5WHstodzWKjTM/8eqSw6/0GKh/kjWMajnhXBq/TNgho
	dDAEag/p30Z/UXtqowntSe3RmY8z/rw85isTxeodBMJXHueOngozc+D7t1jpdE2hfIAo
	hkto3xLaWT9l/hxmYrfAjl0ggkpoMIoXINt0UFX/6mw3D5QHqPicA64wtSo056odoKoi
	hIEyVizDItYY6dCih6S0sX94gToYOoM1oP/8w2W2Hvc9k38EA8XKfIdaCU0DiVSxMIAq
	hh64RiWf79GSMG5f0/AIFzrKYgaTyEXX7z4KsOKDOKNusKH8pzGFlzsF5OPFZecdjgJo
	R3Ug==
X-Gm-Message-State: APjAAAXBEM/vtMficcJfpVUjGEClI8+nFUr7ESrz6/LzKv/ho7nLChTq
	EL8mNE7oJ6HKRIUrtvSSNi8oxbQ3DCQ=
X-Google-Smtp-Source: APXvYqyeMj3XxVEaX35YF0c5OJlD+fRd8xLdAeQquNgH5LpP57aaK8pc6Qw2gXqzeUmDEqzKD7EKIQ==
X-Received: by 2002:a2e:8592:: with SMTP id b18mr18871994lji.18.1568123024989; 
	Tue, 10 Sep 2019 06:43:44 -0700 (PDT)
Received: from manatarms-greyskull.lan.mikrodidakt.se ([213.185.29.22])
	by smtp.gmail.com with ESMTPSA id
	k21sm4169304lfm.68.2019.09.10.06.43.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 10 Sep 2019 06:43:44 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2019 15:43:27 +0200
Message-Id: <20190910134328.27305-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake-user-manual: Correct description for _append/_prepend/_remove
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
X-List-Received-Date: Tue, 10 Sep 2019 13:43:45 -0000
Content-Transfer-Encoding: 8bit

The effects of _append/_prepend/_remove are applied when a variable
is expanded, not after parsing has completed.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 88622421..6b49d7fa 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -369,9 +369,8 @@
 
             <para>
                 These operators differ from the ":=", ".=", "=.", "+=", and "=+"
-                operators in that their effects are deferred
-                until after parsing completes rather than being immediately
-                applied.
+                operators in that their effects are applied at variable
+                expansion time rather than being immediately applied.
                 Here are some examples:
                 <literallayout class='monospaced'>
      B = "bval"
@@ -435,7 +434,7 @@
 
             <para>
                 Like "_append" and "_prepend", "_remove"
-                is deferred until after parsing completes.
+                is applied at variable expansion time.
             </para>
         </section>
 
-- 
2.21.0


