Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A3DA17D17B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Mar 2019 15:23:29 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2SFMqNT023180
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 28 Mar 2019 08:23:02 -0700
Received: from soho-mhatle-m.local (172.25.36.230) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 28 Mar 2019 08:22:41 -0700
To: William Kennington <wak@google.com>
References: <20190327174042.97926-1-mark.hatle@windriver.com>
	<20190327174042.97926-2-mark.hatle@windriver.com>
	<CAPnigKk3_gv8izX0kMqCZKs7ngwH3-bYk7-hW094N-fbHrTSzQ@mail.gmail.com>
	<CAPnigKnBVSa5rr11xQ3Qs0Gv4uyyTpQKQ0ANS0ezzTrSO=xxSQ@mail.gmail.com>
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
Message-ID: <c5c31e46-e953-30b9-6187-95255af1777e@windriver.com>
Date: Thu, 28 Mar 2019 10:22:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.5.3
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
X-List-Received-Date: Thu, 28 Mar 2019 15:23:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 3/27/19 8:47 PM, William Kennington wrote:
> A follow up for the case I am talking about, your commit will try to
> download the second fetch even if it doesn't have to. I realize this
> is still better than breaking the unpack stage, but we should be able
> to support this type of thing since the data is already there.

There is no direct mechanism that I'm aware of to be able to avoid the secondary
fetch.  So the original patch would certainly permit and expect that behavior.

The 'download' sets up the lock, and then calls needs_update and proceeds from
there. (with a true/false answer).

It may be possible to call the -git- needs_update from within the gitsm
'download' prior to trying to directly call the 'git.Download()'...  Since the
lock is held, this is a safe operation to go..

So something like:

-        Git.download(self, ud, d)
+        if Git.need_update(ud, d):
+             Git.download(self, ud, d)

--Mark

> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 429998b3..718605e2 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -961,6 +961,26 @@ class FetcherNetworkTest(FetcherTest):
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/json/config')), msg='Missing submodule config
> "extern/json"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/sanitizers/config')), msg='Missing submodule
> config "extern/sanitizers"')
> 
> +    def test_git_submodule_no_update_CLI11(self):
> +        """ Prevent regression on update detection not finding
> already downloaded commits """
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=da901cca542612a133efcb04e8e78080186991e4"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +
> +        self.d.setVar("BB_NO_NETWORK", 1)
> +        # CLI11 that pulls in a newer nlohmann-json which we already fetched
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=899100c1619ea1282620604ac9199010e65f907e"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        # Previous cwd has been deleted
> +        os.chdir(os.path.dirname(self.unpackdir))
> +        fetcher.unpack(self.unpackdir)
> +
> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/googletest/config')), msg='Missing submodule
> config "extern/googletest"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/json/config')), msg='Missing submodule config
> "extern/json"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path,
> '.git/modules/extern/sanitizers/config')), msg='Missing submodule
> config "extern/sanitizers"')
> +
>      def test_git_submodule_aktualizr(self):
>          url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
>          fetcher = bb.fetch.Fetch([url], self.d)
> 
> On Wed, Mar 27, 2019 at 1:22 PM William Kennington <wak@google.com> wrote:
>>
>> I think this looks good in terms of fixing the issue. It might be
>> overly pessimistic in triggering need_update since it doesn't re-use
>> git metadata, so it isn't just looking at the tree for each download.
>>
>> Out of curiosity, since git does its own locking, is there any harm in
>> not taking the download locks but reading the metadata of the bare git
>> repos? No downloader should ever be purging commits from the tree, so
>> needs_update would never return a false negative.
>>
>> On Wed, Mar 27, 2019 at 10:41 AM Mark Hatle <mark.hatle@windriver.com> wrote:
>>>
>>> If the system had previously fetched a source repository for use by gitsm,
>>> and then the SRCREV was updated and the new commit already existed, the system
>>> would not re-evaluate the submodules and update them accordingly.
>>>
>>> The cause of this issue was that need_update was being used, unmodified, from
>>> the base git fetcher.  It did not have any knowledge, nor did it care if we
>>> were moving commits and needed to re-evaluate what was happening due to this
>>> switch.
>>>
>>> To fix the issue, during the download process we add all processed (by
>>> gitsm) srcrevs to the git config file, as bitbake.srcrev.  This allows us to
>>> use a new need_update function that not only checks if the git commit is
>>> present, but if we have previously processed this commit to ensure all of the
>>> submodule components are also present.
>>>
>>> This approach is used, instead of iterating over the submodules in need_update
>>> to avoid a potential race condition that has affected us in the past.  The
>>> need_update is called only with the parent locking.  Any time we need to dive
>>> into the submodules, we need to lock, and unlock them, at each stage.  This
>>> opens the possibility of errors in either the code, or unintended race
>>> conditions with rm_work.
>>>
>>> This issue was discovered by William A. Kennington III <wak@google.com>.  The
>>> included test case was also written by him, and included unmodified.
>>>
>>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
>>> ---
>>>  lib/bb/fetch2/gitsm.py | 20 ++++++++++++++++++++
>>>  lib/bb/tests/fetch.py  | 19 +++++++++++++++++++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>>> index b21fed26..32389130 100644
>>> --- a/lib/bb/fetch2/gitsm.py
>>> +++ b/lib/bb/fetch2/gitsm.py
>>> @@ -147,6 +147,23 @@ class GitSM(Git):
>>>
>>>          return submodules != []
>>>
>>> +    def need_update(self, ud, d):
>>> +        if Git.need_update(self, ud, d):
>>> +            return True
>>> +
>>> +        try:
>>> +            # Check for the nugget dropped by the download operation
>>> +            known_srcrevs = runfetchcmd("%s config --get-all bitbake.srcrev" % \
>>> +                            (ud.basecmd), d, workdir=ud.clonedir)
>>> +
>>> +            if ud.revisions[ud.names[0]] not in known_srcrevs.split():
>>> +                return True
>>> +        except bb.fetch2.FetchError:
>>> +            # No srcrev nuggets, so this is new and needs to be updated
>>> +            return True
>>> +
>>> +        return False
>>> +
>>>      def download(self, ud, d):
>>>          def download_submodule(ud, url, module, modpath, d):
>>>              url += ";bareclone=1;nobranch=1"
>>> @@ -157,6 +174,9 @@ class GitSM(Git):
>>>              try:
>>>                  newfetch = Fetch([url], d, cache=False)
>>>                  newfetch.download()
>>> +                # Drop a nugget to add each of the srcrevs we've fetched (used by need_update)
>>> +                runfetchcmd("%s config --add bitbake.srcrev %s" % \
>>> +                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
>>>              except Exception as e:
>>>                  logger.error('gitsm: submodule download failed: %s %s' % (type(e).__name__, str(e)))
>>>                  raise
>>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>>> index 25732627..429998b3 100644
>>> --- a/lib/bb/tests/fetch.py
>>> +++ b/lib/bb/tests/fetch.py
>>> @@ -942,6 +942,25 @@ class FetcherNetworkTest(FetcherTest):
>>>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
>>>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
>>>
>>> +    def test_git_submodule_update_CLI11(self):
>>> +        """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
>>> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
>>> +        fetcher = bb.fetch.Fetch([url], self.d)
>>> +        fetcher.download()
>>> +
>>> +        # CLI11 that pulls in a newer nlohmann-json
>>> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
>>> +        fetcher = bb.fetch.Fetch([url], self.d)
>>> +        fetcher.download()
>>> +        # Previous cwd has been deleted
>>> +        os.chdir(os.path.dirname(self.unpackdir))
>>> +        fetcher.unpack(self.unpackdir)
>>> +
>>> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
>>> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
>>> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
>>> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
>>> +
>>>      def test_git_submodule_aktualizr(self):
>>>          url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
>>>          fetcher = bb.fetch.Fetch([url], self.d)
>>> --
>>> 2.16.0.rc2
>>>


