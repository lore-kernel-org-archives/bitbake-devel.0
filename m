Return-Path: <wak@google.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 5540E7D01A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Mar 2019 01:52:43 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id q1so2648063pgv.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=THW6QoOpgkR33X5R3MfJ1RtHwG4uAz6ijs9Li0Hmjdg=;
	b=u71YKDvfsxUFTMklWPnM6UPb0ctfcu5ivLHvD5789+/8OG6JGdM8NDV6NNT6FrVWmD
	qKKHTrQDZnHBixHmfO0YsklDjePjUlTbkrlKnHJDqGguVXtPKKqp6dCHPxpyz9Ve2Edo
	2Q9z8gDtYDj1kwLjHqA8uPXeaLfZa9p3fsxZ9IwV8hid3vrp+LaoCx9LlZsRas3MSkyq
	Xj0wftwVcuVBBBi+YGREptpcXToVcbd1rukMGAWbW4sAaq3vS/M+k+GXvq7LKtQ1C1u2
	czAVLVY8fEs9cmYwAf0Dq3ySqQMlQzy34vLrLNR884WM7hkJDYxAWGzE3AFqHJ+OmIQJ
	r5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=THW6QoOpgkR33X5R3MfJ1RtHwG4uAz6ijs9Li0Hmjdg=;
	b=f5oyUUALcQDSu/EcewNvQ6NdzJ5T8Zw3C+6ncd02gA8Er/xT+Yi6bS/pDj1XkB+gPi
	GrWgp47Mvt4uW746xrPdhOZaLmlqnkcFNAURxJr/G9HboMzFnI8vtgeKu8HG8CZCZK+C
	NRybamLDJOetRu+xiLBhEzkv13DpXLrYOtzyTZTITeFoqWqYpY7kvIv4gvaKll6FoBMr
	PBOo/sZ+061uyaAClpenXYuANk92MtgAknjVSf/oGzltsncqRktlu/i4dzsxoZTqQoPA
	i0YGesrm5LtA8zAR3IKJ/sP8UBCVHTJHrVZWkBORhfsdX44cHcObfDyEtEEVJFous43m
	YwUQ==
X-Gm-Message-State: APjAAAWPBOWonB1PsE4vRqBxvTLQrNXvPKIfdhh/c92w1jlz/tnOtn8L
	NzZrh6n3mfhFPRVrk7Gwv7v18KpMd70SSQ==
X-Google-Smtp-Source: APXvYqwtH+/pSB8/HB9hLg9Wk7X9iRcPdYIEKbtr4F/JoDSREwiCYxW/MVB5CuFPevWTb88YO81OgA==
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr38222939pfn.50.1553737963844; 
	Wed, 27 Mar 2019 18:52:43 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com
	([2620:15c:2c5:3:25d0:d4a1:62af:2759])
	by smtp.gmail.com with ESMTPSA id
	e123sm34767281pfe.35.2019.03.27.18.52.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Mar 2019 18:52:42 -0700 (PDT)
From: "William A. Kennington III" <wak@google.com>
To: Mark Hatle <mark.hatle@windriver.com>
References: <20190327174042.97926-1-mark.hatle@windriver.com>
	<20190327174042.97926-2-mark.hatle@windriver.com>
	<CAPnigKk3_gv8izX0kMqCZKs7ngwH3-bYk7-hW094N-fbHrTSzQ@mail.gmail.com>
	<CAPnigKnBVSa5rr11xQ3Qs0Gv4uyyTpQKQ0ANS0ezzTrSO=xxSQ@mail.gmail.com>
Message-ID: <8c4f14ad-0886-a715-4c81-42b68ff2ae4d@google.com>
Date: Wed, 27 Mar 2019 18:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPnigKnBVSa5rr11xQ3Qs0Gv4uyyTpQKQ0ANS0ezzTrSO=xxSQ@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] gitsm: Add need_update method to determine when we are going to a new SRCREV
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
X-List-Received-Date: Thu, 28 Mar 2019 01:52:43 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Sorry, bad send from gmail which seems to want to wrap and deduplicate 
my text. You can apply the following patch to test against over pessimism.

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 429998b3..718605e2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -961,6 +961,26 @@ class FetcherNetworkTest(FetcherTest):
          self.assertTrue(os.path.exists(os.path.join(repo_path, 
'.git/modules/extern/json/config')), msg='Missing submodule config 
"extern/json"')
          self.assertTrue(os.path.exists(os.path.join(repo_path, 
'.git/modules/extern/sanitizers/config')), msg='Missing submodule config 
"extern/sanitizers"')

+    def test_git_submodule_no_update_CLI11(self):
+        """ Prevent regression on update detection not finding already 
downloaded commits """
+        url = 
"gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=da901cca542612a133efcb04e8e78080186991e4"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+
+        self.d.setVar("BB_NO_NETWORK", 1)
+        # CLI11 that pulls in a newer nlohmann-json which we already 
fetched
+        url = 
"gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=899100c1619ea1282620604ac9199010e65f907e"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 
'.git/modules/extern/googletest/config')), msg='Missing submodule config 
"extern/googletest"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 
'.git/modules/extern/json/config')), msg='Missing submodule config 
"extern/json"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 
'.git/modules/extern/sanitizers/config')), msg='Missing submodule config 
"extern/sanitizers"')
+
      def test_git_submodule_aktualizr(self):
          url = 
"gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
          fetcher = bb.fetch.Fetch([url], self.d)


