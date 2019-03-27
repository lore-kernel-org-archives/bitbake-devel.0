Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0DB927D15C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 16:01:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2RG0Trw020377
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Mar 2019 09:01:25 -0700
Received: from soho-mhatle-m.corp.ad.wrs.com (147.11.4.70) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 27 Mar 2019 09:01:18 -0700
To: "William A. Kennington III" <wak@google.com>,
	<bitbake-devel@lists.openembedded.org>
References: <20190327060316.136092-1-wak@google.com>
From: Mark Hatle <mark.hatle@windriver.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.hatle@windriver.com; prefer-encrypt=mutual; keydata=
	mQENBFYKxFgBCACt/pzutBp6p/xVKTFJjHbM3KpQKCblyot/YP+bpTr51Hrc5xDXBQhoG7TC
	aIRvRIvbhEevEQK9y04gW3JK/5lobq5ORebolcsHlYBUvpNeIPjupLQwGvz/TPtrLRNGLqDC
	rvsM6OA2XbQ2bwzxWaSQS3ImE2O2iXOZn9HhThMGeDB4Nff3fgUvXOTDIrgWOn9K2DgLL7Yc
	zkUIlFdj+Nraksd/7BSk8oH6tjeBVhFqSFvKta9QxWgdr58oPaTYaW/xNqUjlLrbJuMw/MSe
	xzuYfdfDfm6J8kRjMOnwQ0n8svJElzqAk+d83ow38gpGQ+LkjGgnf8ZFJ4rUJFADroX3ABEB
	AAG0JU1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAd2luZHJpdmVyLmNvbT6JATcEEwEIACEFAlYK
	xFgCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQfv796/r0vvlvZAf9Gs+eN320yhRW
	V/fZCsngKhmOK4v3HrTwFrkSmoD9QHQiE/5IPdNacHwIPwZx07tNBohB8xOeNqCPRYRBwGhA
	AnxKOPyd0nnm6ZhPzbA57v4x3IGRQr4QzvcBTASJq91l3Ew4lpAslyx5w1DPPqRD7G8ycDKg
	peKyDwmdkvCunVisSAQI3XIMq2y230biTO98tDPEezg+lg+yTsz9ZT33F5KNuWrpf8VL5fG/
	mt+kAv7wtsx/KTRbqhH3iFXF6eBSwMjAfTXFlkLfbM9riJGXrWEl9n2S2R3cDHNHug0lb8f4
	whK370KEO4OwRKIYW/VUBmzk5XZUE9DTlDSV8ycsrrkBDQRWCsRYAQgAwK3FuHCE+HW3YWdH
	PUjeSn5p//xJ57u8g2rng8zm9zNjmYgpPv5UxozaD9i2jf4mlQLHGGOezhHae8K4Nj70oVcv
	8AmwcrJa9i9WL1oy/9R3fHMWf/Ctt9VXTO0qlCuq6PDzaUfvsXR61aJIjTKNQTOjCLjY1vXm
	VSewUgARysmA8WrjTfwGBihMBxAX0+kIjx8nOlam0WvekMBXZ0AbS56oTLRxYao6DI3GeB/N
	oWPy/5DfuTKaSdM0Pf8al20x9RuNN5/HLMlyDH/k8bIa1xd9aAqW+Feiw5gC107V2E6ULyIy
	q6em2UrsmIRxrvpHqbNgQKqvTehJ+V/i4g/uOwARAQABiQEfBBgBCAAJBQJWCsRYAhsMAAoJ
	EH7+/ev69L755XAH/3ZcNhooqd9OBhFkvXm1iWZ8EoC7motWqVn2oEyxoonsg8AD9kFXiN+T
	dYp7dH99EZu9q4ptj56AXm4uHzOgywL/5/V2TY6twCGAjUGzDjAB5gzoi+JLIBlDiyOip0eL
	QswIhRk473xy3j8DA4oVamnSPWgyNJ+qsdt37YWDzoDFFvtDoRU7Eb+znfIMDKzlny0XU/8L
	cW1bNHJlpv/78GPdfP4tjysEd8MuA5jf5o5w4XqcwTqalffEJtQ/s3pbkstEi7qm5uPui5Kt
	gq6YYLSqcSNe0GWAF9/T+qwyo7burSTxUWCWtMmlXdAQLW9SynLhB3Jbch0nFAh0fCKi6yY=
Organization: Wind River Systems
Message-ID: <0ce1ca05-959c-b006-d49a-75b9086282a0@windriver.com>
Date: Wed, 27 Mar 2019 09:01:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190327060316.136092-1-wak@google.com>
Subject: Re: [PATCH] gitsm: Check all submodules for updates
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
X-List-Received-Date: Wed, 27 Mar 2019 16:01:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 3/27/19 1:03 AM, William A. Kennington III via bitbake-devel wrote:
> Currently, our gitsm fetcher is inheriting the need_update function from
> the git fetcher. This results in our do_fetch checking for updates only
> if the SRCREV is missing from the top-level project.

The theory here is that if the original (fetched) repository exists, and nothing
has changed, then there is no reason to further iterate into the submodules --
since by definitely they could not have changed, in a meaningful way, since the
main git didn't change it's references to them.

> Unfortunately, this doesn't take into account the dependent SRCREVs
> missing from submodules due to a lack of the submodule existing
> during the first checkout, or arbitrary download cache purges of
> submodule data.

Looking at what is happening via the test case included, the system fetches the
upstream repository once.. and sets up everything.

It then changes the SRCREV (emulating the condition of say two package versions
that point to the same repo, but different commits.)  The system says, well I
have already downloaded a repo with that srcrev -- no reason to iterate and do
anymore work, then when it unpacks and iterates it fails due to the new items
not being available as expected.

So really, we need to resync/update the fetch if the SRCREV has changed from the
last fetch to the new fetch..  this should then trigger the new fetch/update
behavior automatically.

...but I'm not sure we can know if the SRCREV has actually changed (the
reference to it) from the last time we fetched...

> The most trivial way to encounter this is to have gitsm fetch a software
> project before and after adding submodules. When it goes to use the
> update that has submodules it will think that it has all of the needed
> revisions since it checked the top-level repo. However none of those
> submodules will exist in the downloads cache since they weren't included
> in the original commit.

What it was intended to do was, if the main repository was updated (for any
reason), then it was supposed to iterate over all of the submodules, and then
update each one independently.  Since the main repository is not being updated
(we already have the commit, we just were not using it), it never updated so it
never iterated.

I trust what your change below does fixes the issue, but I'm still wondering if
there is some more fundamental issue that has to be addressed first.

(BTW I really appreciate the test case being added.  It will help prevent this
type of problem in the future -- and also gives me a chance to replicate what is
happening with and without the rest of the change.)

I'm trying to figure out if there might be a simpler way to check if the SRCREV
has changed from the initial download, even if we have the new SRCREV in the
repository.

--Mark

> Tested:
>     Ran the unit test suite with just the new unit test to make sure it
>     fails repeatedly. Then applied the fix and ran it some more to
>     ensure the fix works.
> 
> Signed-off-by: William A. Kennington III <wak@google.com>
> ---
>  lib/bb/fetch2/gitsm.py | 24 ++++++++++++++++++++++++
>  lib/bb/tests/fetch.py  | 19 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index b21fed26..f1ecd170 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -36,6 +36,7 @@ from   bb.fetch2.git import Git
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
>  from   bb.fetch2 import Fetch
> +from   bb.fetch2 import FetchData
>  from   bb.fetch2 import BBFetchException
>  
>  class GitSM(Git):
> @@ -147,6 +148,29 @@ class GitSM(Git):
>  
>          return submodules != []
>  
> +    def need_update(self, ud, d):
> +        if Git.need_update(self, ud, d):
> +            return True
> +        class NeedUpdateException(Exception):
> +            pass
> +        def need_update_submodule(ud, url, module, modpath, d):
> +            url += ";bareclone=1;nobranch=1"
> +            lud = FetchData(url, d, False)
> +            lud.setup_localpath(d)
> +            if lud.lockfile:
> +                lf = bb.utils.lockfile(lud.lockfile)
> +            try:
> +                if lud.method.need_update(lud, d):
> +                    raise NeedUpdateException
> +            finally:
> +                if lud.lockfile:
> +                    bb.utils.unlockfile(lf)
> +        try:
> +            self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
> +            return False
> +        except NeedUpdateException:
> +            return True
> +
>      def download(self, ud, d):
>          def download_submodule(ud, url, module, modpath, d):
>              url += ";bareclone=1;nobranch=1"
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 25732627..429998b3 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -942,6 +942,25 @@ class FetcherNetworkTest(FetcherTest):
>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
>  
> +    def test_git_submodule_update_CLI11(self):
> +        """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +
> +        # CLI11 that pulls in a newer nlohmann-json
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        # Previous cwd has been deleted
> +        os.chdir(os.path.dirname(self.unpackdir))
> +        fetcher.unpack(self.unpackdir)
> +
> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
> +
>      def test_git_submodule_aktualizr(self):
>          url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
>          fetcher = bb.fetch.Fetch([url], self.d)
> 


