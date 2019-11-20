Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 6A9EE7F7A6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 18:30:00 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xAKITrKh028273
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Wed, 20 Nov 2019 12:29:55 -0600
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>,
	bitbake-devel@lists.openembedded.org
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191120093412.11519-8-jean-marie.lemetayer@savoirfairelinux.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <df6a4b5e-b2b8-900e-bc48-1ff6c35bde36@kernel.crashing.org>
Date: Wed, 20 Nov 2019 12:29:53 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120093412.11519-8-jean-marie.lemetayer@savoirfairelinux.com>
Cc: paul.eggleton@linux.intel.com, rennes@savoirfairelinux.com
Subject: Re: [PATCH v3 7/7] tests/fetch.py: add npm tests
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
X-List-Received-Date: Wed, 20 Nov 2019 18:30:00 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

First thanks for the tests!  A few comments inline

On 11/20/19 3:34 AM, Jean-Marie LEMETAYER wrote:
> This commit adds some basic tests for the npm fetcher:
> 
>  - bb.tests.fetch.NPMTest.test_npm
>  - bb.tests.fetch.NPMTest.test_npm_name_invalid
>  - bb.tests.fetch.NPMTest.test_npm_name_none
>  - bb.tests.fetch.NPMTest.test_npm_no_network_no_tarball
>  - bb.tests.fetch.NPMTest.test_npm_no_network_with_tarball
>  - bb.tests.fetch.NPMTest.test_npm_registry_alternate
>  - bb.tests.fetch.NPMTest.test_npm_registry_invalid
>  - bb.tests.fetch.NPMTest.test_npm_registry_none
>  - bb.tests.fetch.NPMTest.test_npm_version_invalid
>  - bb.tests.fetch.NPMTest.test_npm_version_latest
>  - bb.tests.fetch.NPMTest.test_npm_version_none
> 
> Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
> ---
>  lib/bb/tests/fetch.py | 103 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 83fad3ff..d1091fa7 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2008,3 +2008,106 @@ class GitLfsTest(FetcherTest):
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
> +    def test_npm_no_network_no_tarball(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        self.d.setVar('BB_NO_NETWORK', '1')

Since this is a BB_NO_NETWORK=1 case, the @skipIfNoNetwork() should not be here,
since it should not need the network to perform the test.

> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        with self.assertRaises(bb.fetch2.NetworkAccess):
> +            fetcher.download()
> +
> +    @skipIfNoNpm()
> +    @skipIfNoNetwork()
> +    def test_npm_no_network_with_tarball(self):
> +        url = 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        self.d.setVar('BB_NO_NETWORK', '1')

Same here.

If any other the ones below work off local files, then similarly we shouldn't
skip running them on a no network config.

--Mark

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
> +        with self.assertRaises(bb.fetch2.ParameterError):
> +            fetcher = bb.fetch.Fetch([url], self.d)
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

