Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id 4A2907C59C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2019 19:38:17 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 8319C5C016E;
	Mon, 28 Jan 2019 20:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1548704297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=YNGoyorr2xdUOjQvnRszuoO0dVdpi/sFt5QzNC0EIWA=;
	b=Jshs0elbtgp364pagjTvuskYtEEv6uDuNQIn24JdJl/c7rNhyS91pSOg5e4BWZl7rGERdW
	lztGl1rKOQ3VVU5yDDQfyPdS8yDOq4HWyQacMQ0DTym+QHW9Hx8wd4GHzHAsGW77IvA4qh
	EZkACxk6yVigdO10nVLd1g+y21J+vJA=
MIME-Version: 1.0
Date: Mon, 28 Jan 2019 20:38:17 +0100
From: Stefan Agner <stefan@agner.ch>
To: Mark Hatle <mark.hatle@windriver.com>
In-Reply-To: <20190127165712.118078-2-mark.hatle@windriver.com>
References: <20190127165712.118078-1-mark.hatle@windriver.com>
	<20190127165712.118078-2-mark.hatle@windriver.com>
Message-ID: <8662aa650e33602e418cc6dbcb178098@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: bitbake-devel@lists.openembedded.org, liu.ming50@gmail.com
Subject: Re: [PATCH] gitsm: The fetcher did not process some recursive submodules properly.
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
X-List-Received-Date: Mon, 28 Jan 2019 19:38:17 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 27.01.2019 17:57, Mark Hatle wrote:
> Move the submodule processing outside of the if statement to avoid any
> optimizations that may happen.
> 
> Update the test cases to include the additional case, and split the other
> test cases into individual tests to make it easier to figure out what
> the failure may be.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>

I can confirm that this resolves the issue we have been seeing:

Tested-by: Stefan Agner <stefan.agner@toradex.com>

Thanks Mark for looking into this!

--
Stefan

> ---
>  lib/bb/fetch2/gitsm.py |  4 +++-
>  lib/bb/tests/fetch.py  | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index f45546b..b21fed2 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -198,6 +198,8 @@ class GitSM(Git):
>  
>          Git.unpack(self, ud, destdir, d)
>  
> -        if not ud.bareclone and self.process_submodules(ud,
> ud.destdir, unpack_submodules, d):
> +        ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
> +
> +        if not ud.bareclone and ret:
>              # Run submodule update, this sets up the directories --
> without touching the config
>              runfetchcmd("%s submodule update --recursive --no-fetch"
> % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index e9ad807..522d202 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -912,6 +912,7 @@ class FetcherNetworkTest(FetcherTest):
>          if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
>              self.assertTrue(os.path.exists(os.path.join(repo_path,
> 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule
> missing')
>  
> +    def test_git_submodule_dbus_broker(self):
>          # The following external repositories have show failures in
> fetch and unpack operations
>          # We want to avoid regressions!
>          url =
> "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
> @@ -928,16 +929,35 @@ class FetcherNetworkTest(FetcherTest):
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule
> config "subprojects/c-sundry"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule
> config "subprojects/c-utf8"')
>  
> +    def test_git_submodule_CLI11(self):
>          url =
> "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
>          fetcher = bb.fetch.Fetch([url], self.d)
>          fetcher.download()
>          # Previous cwd has been deleted
>          os.chdir(os.path.dirname(self.unpackdir))
>          fetcher.unpack(self.unpackdir)
> +
> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/googletest/config')), msg='Missing submodule
> config "extern/googletest"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/json/config')), msg='Missing submodule config
> "extern/json"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/sanitizers/config')), msg='Missing submodule
> config "extern/sanitizers"')
>  
> +    def test_git_submodule_aktualizr(self):
> +        url =
> "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        # Previous cwd has been deleted
> +        os.chdir(os.path.dirname(self.unpackdir))
> +        fetcher.unpack(self.unpackdir)
> +
> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/partial/extern/isotp-c/config')), msg='Missing submodule
> config "partial/extern/isotp-c/config"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/partial/extern/isotp-c/modules/deps/bitfield-c/config')),
> msg='Missing submodule config
> "partial/extern/isotp-c/modules/deps/bitfield-c/config"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> 'partial/extern/isotp-c/deps/bitfield-c/.git')), msg="Submodule of
> submodule isotp-c did not unpack properly")
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/tests/tuf-test-vectors/config')), msg='Missing submodule
> config "tests/tuf-test-vectors/config"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/third_party/googletest/config')), msg='Missing submodule
> config "third_party/googletest/config"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/third_party/HdrHistogram_c/config')), msg='Missing
> submodule config "third_party/HdrHistogram_c/config"')
> +
>  class TrustedNetworksTest(FetcherTest):
>      def test_trusted_network(self):
>          # Ensure trusted_network returns False when the host IS in the list.

