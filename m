Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail.openembedded.org (Postfix) with ESMTP id 9E7FD7F316
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:49 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id f22so5998626wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=A3QOoxgDN8rfl1QXneTwxzu8RojS7hAOKUM8CUEPh9o=;
	b=b6kM6Phsu3r4P90dXMTyJn5n+pjgW97JWPGdHHHXshy+dAS0dEsz/zGqoNlRswIwCP
	v4W1D0MJ9T/h5R+ItUNFfXpkMRgHujXyii9wy8kx97NI9zm2M8cYVOO7utscwd5o0/Q1
	g1L2MN3tiRBp9Itt44uBzR1BMcdlo6BvUqNTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=A3QOoxgDN8rfl1QXneTwxzu8RojS7hAOKUM8CUEPh9o=;
	b=rExxRzLHJEVJSsuw+ohkwcxy7xcYbW9AO7/yBIFz684GEWLJI4EBHmfxu/6ar5y4z+
	6BFkgQcEJHMGgVDeCfWdElVI+1HN0lpVeR6c9us9i7dyswSxxKYEpABvQJiuWnH8TJm9
	fX1AMNvqehGmM20bvfJjzNGaIR19R3RXgMnqevLJMDdrVb5+lA/byocyR6+rYYvk6b2e
	XSCmwRdfA+fG8zvm41NGGe3ypTPRkFqNuANBuxEollklDeeeYO6zyMqiQn0J3Qsn2WM4
	YcmwE/vnfY3Sw8JwrnUpVi1CwU58QrYMCTCGp3RsVf8d5vfBob9vLyX7OG0ukg9zYfqJ
	Zmfg==
X-Gm-Message-State: APjAAAW7zqbkbpOkLNxs2N1Gdo+aBjFjRNc3vFf/KRUvM9DUnZ1znsvz
	nKD0bC2vZ3lokOq14pfo4zUjxy2JD/c=
X-Google-Smtp-Source: APXvYqzGL2BA1iMsXupxgzInsuvCtgp34vchASBhZXeSEpARotkYvmOwQX8nWE5xz9zaHtUG4/Tv4A==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr7068105wme.152.1569587629970; 
	Fri, 27 Sep 2019 05:33:49 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.48
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:39 +0100
Message-Id: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/9] hashserv: Don't daemonize server process
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:49 -0000
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

The hash server process is terminated and waited on with join(), so it
should not be a daemon. Daemonizing it cause races with the server
cleanup, especially in the selftest because the process may not have
terminated and cleanup up its socket before the test cleanup runs and
tries to do it.

[YOCTO #13542]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py      | 1 -
 lib/hashserv/tests.py | 1 -
 2 files changed, 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0c540028ae..20ef04d3ff 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -399,7 +399,6 @@ class BBCooker:
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
                 self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
-                self.hashserv.process.daemon = True
                 self.hashserv.process.start()
             self.data.setVar("BB_HASHSERVE", self.hashservaddr)
             self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 6584ff57b4..a5472a996d 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -32,7 +32,6 @@ class TestHashEquivalenceServer(object):
 
         self.server = create_server(self.get_server_addr(), self.dbfile)
         self.server_thread = multiprocessing.Process(target=self._run_server)
-        self.server_thread.daemon = True
         self.server_thread.start()
         self.client = create_client(self.server.address)
 
-- 
2.20.1


