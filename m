Return-Path: <wak@google.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 446897CFA4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Mar 2019 01:59:12 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id k2so4186430plt.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 18:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=ELNRnEaMnzjrvAeao9//ZxFK7BY+KWUMIJpiv/nQRk4=;
	b=NMdpfF1A6Y88063sO/MtlxKjgYVtZ0BYY9jZCtJmaL2a+ZCMxYt3HCN9Aj34CA3GZV
	fEa6KbrxhgYXsqXhnCmu9YiCDm8srWXZkI+jVcpRN6bXNeJP16qPe+MXB2JfX53/XGXz
	4Y4jxvFsFdl6at/d4B8vRoPgvFL3rcq9dwWPRmwuaplLOtBiZ4z2mqArOf1msDDVq7bC
	Xtbv76z0NJPBxfxZUdc4cYH5zWstlVZdGyKmw7LzPEgAIzqEW2IEQMjj2100mVS+v6oW
	lrzG8hs6/6I5ze2qpN21P1J0ADwburhzz4cSi4d90/SOty2cUP1Bh+fgAxaU5gHphszq
	tfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=ELNRnEaMnzjrvAeao9//ZxFK7BY+KWUMIJpiv/nQRk4=;
	b=dLswUist/BzOZQGHfXOHBF8xv3VcAK6oT4eioK21mzMyViW2xX9H+ADS39v1NYN2CT
	rO8Z0xWPt7VKLA0y3q1lC+N4DJ4yfQn5HyK0zBaNA98k+wHrtVNxXU5FuaclvNQtQvwl
	ZguWsqru3gzPQo72x2Lhv+zr2xa7Pz0ZFY6wr/ZXaOVcZQfGrIM9JKktw50j09ELfQgR
	6gL04rXOaW7qnuflgCxJSPX9VXggU9PsYVjXtpSUX4nzTJassmr3ptPzv9SSAvQc4IUp
	x6brvd51TvxMO6kIsnMyLSSeJeWXxCu3+GcvVj3LFagm5ZmadB/fd06/HxVKPAkLEbiu
	SsUg==
X-Gm-Message-State: APjAAAV6pMt7p1YIdfVrxXyhYOJ/q5CAune+VJ5qWhL9AVnWRJuKHsyK
	dEFgq0wnLm74QNnk616jaP0nIwQ623a9jg==
X-Google-Smtp-Source: APXvYqyigOTOh2DLkkdDkqzpsLrP0LEKYcF43bo/i0hc5GUA8YBicEP94ug9b57xrJdRPM8cvOIbhw==
X-Received: by 2002:a17:902:9001:: with SMTP id
	a1mr10128864plp.96.1553738352910; 
	Wed, 27 Mar 2019 18:59:12 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com
	([2620:15c:2c5:3:25d0:d4a1:62af:2759])
	by smtp.gmail.com with ESMTPSA id
	138sm47179958pfz.18.2019.03.27.18.59.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Mar 2019 18:59:12 -0700 (PDT)
From: "William A. Kennington III" <wak@google.com>
To: Mark Hatle <mark.hatle@windriver.com>
References: <20190327174042.97926-1-mark.hatle@windriver.com>
	<20190327174042.97926-2-mark.hatle@windriver.com>
	<CAPnigKk3_gv8izX0kMqCZKs7ngwH3-bYk7-hW094N-fbHrTSzQ@mail.gmail.com>
	<CAPnigKnBVSa5rr11xQ3Qs0Gv4uyyTpQKQ0ANS0ezzTrSO=xxSQ@mail.gmail.com>
	<8c4f14ad-0886-a715-4c81-42b68ff2ae4d@google.com>
Message-ID: <3e24188e-1f71-24ab-2719-866bd339a66c@google.com>
Date: Wed, 27 Mar 2019 18:59:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8c4f14ad-0886-a715-4c81-42b68ff2ae4d@google.com>
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
X-List-Received-Date: Thu, 28 Mar 2019 01:59:12 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

One last time, sorrry for the spam. I usually just use git send-email with wrapping options disabled passed to our special sendmail when doing patches and didn't have a proper mail client set up. I tested this against myself and it worked last time so hopefully formatting is fine now.


diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 429998b3..718605e2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -961,6 +961,26 @@ class FetcherNetworkTest(FetcherTest):
          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')

+    def test_git_submodule_no_update_CLI11(self):
+        """ Prevent regression on update detection not finding already downloaded commits """
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=da901cca542612a133efcb04e8e78080186991e4"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+
+        self.d.setVar("BB_NO_NETWORK", 1)
+        # CLI11 that pulls in a newer nlohmann-json which we already fetched
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=899100c1619ea1282620604ac9199010e65f907e"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
+
      def test_git_submodule_aktualizr(self):
          url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
          fetcher = bb.fetch.Fetch([url], self.d)


