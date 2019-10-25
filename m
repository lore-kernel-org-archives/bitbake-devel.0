Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 7A8F07FA8C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 18:28:13 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9PIS014001503
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Fri, 25 Oct 2019 13:28:02 -0500
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>,
	bitbake-devel@lists.openembedded.org
References: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191025083925.14535-4-jean-marie.lemetayer@savoirfairelinux.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <20f382ab-ed8b-0dea-cc80-bb60ffdb6d68@kernel.crashing.org>
Date: Fri, 25 Oct 2019 13:27:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191025083925.14535-4-jean-marie.lemetayer@savoirfairelinux.com>
Cc: paul.eggleton@linux.intel.com, rennes@savoirfairelinux.com
Subject: Re: [RFC][PATCH v2 3/3] tests/fetch.py: add npm tests
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
X-List-Received-Date: Fri, 25 Oct 2019 18:28:13 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

The only test(s) I see missing are the "NoNetwork" tests.

I.e. you should fetch/download a know item, and then verify it ends up in the
DL_DIR in the "correct" format.

Then a second test (with BB_NO_NETWORK = "1") both a positive and negative test.

Negative - try to fetch something from the network and verify it fails.

Positive - use the DL_DIR version (from above) and verify the local version is
re-used, no network is used.

Otherwise the testing looks good to me.  (I don't know enough about the
particular NPM steps to review the other parts.)

--Mark

On 10/25/19 3:39 AM, Jean-Marie LEMETAYER wrote:
> This commit adds some basic tests for the npm fetcher.
> 
> Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
> ---
>  lib/bb/tests/fetch.py | 82 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index a0b656b6..781226d2 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -1988,3 +1988,85 @@ class GitLfsTest(FetcherTest):
>          ud.method._find_git_lfs = lambda d: False
>          shutil.rmtree(self.gitdir, ignore_errors=True)
>          fetcher.unpack(self.d.getVar('WORKDIR'))
> +
> +class NPMTest(FetcherTest):
> +    def skipIfNoNpm():
> +        import shutil
> +        if not shutil.which('npm'):
> +            return unittest.skip('npm not installed, tests being skipped')
> +        return lambda f: f
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        unpackdir = os.path.join(self.unpackdir, 'npm')
> +        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_registry_alternate(self):
> +        url = 'npm://registry.freajs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        unpackdir = os.path.join(self.unpackdir, 'npm')
> +        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_version_latest(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=latest'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        unpackdir = os.path.join(self.unpackdir, 'npm')
> +        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_registry_invalid(self):
> +        url = 'npm://registry.invalid.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        with self.assertRaises(bb.fetch2.FetchError):
> +            fetcher.download()
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_name_invalid(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/invalid;version=1.0.0'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        with self.assertRaises(bb.fetch2.FetchError):
> +            fetcher.download()
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_version_invalid(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=invalid'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        with self.assertRaises(bb.fetch2.FetchError):
> +            fetcher.download()
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_registry_none(self):
> +        url = 'npm://;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        with self.assertRaises(bb.fetch2.MalformedUrl):
> +            fetcher = bb.fetch.Fetch([url], self.d)
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_name_none(self):
> +        url = 'npm://registry.npmjs.org;version=1.0.0'
> +        with self.assertRaises(AttributeError):
> +            fetcher = bb.fetch.Fetch([url], self.d)
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_version_none(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example'
> +        with self.assertRaises(AttributeError):
> +            fetcher = bb.fetch.Fetch([url], self.d)
> 

