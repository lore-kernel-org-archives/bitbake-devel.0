Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail.openembedded.org (Postfix) with ESMTP id 795B56D549
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 10:51:31 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id q18so42648969wrx.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=/biFYhtqzGiWglS+nujKh3D+ZlENwn9MAYOJ2pJES3g=;
	b=VV0l0fU5TXjuOY4aFFRPipPntv033xysP18QUTNkzpUaE7oEr9lw/vsTRVd4nZVcfR
	5PGfFfFmlr+hVJsePJYv0CiRm4cwo0O7yYojzc91o2ILVoNnM+Ru2iGs6CYKkOwd0PCx
	A/6FGRFv/F349+ia9I9yMLRdz/oKC12T8O+BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=/biFYhtqzGiWglS+nujKh3D+ZlENwn9MAYOJ2pJES3g=;
	b=R16mNykrRsT2B4sK4OkQgc9cSKRua45MlINbWQWUlBHoh1DcwMV1EtQuv+nni4SYZV
	pFPJhA+bXCzzu/mTPSoqqSXmuUMwkbWeWTzpl7sIrRchG0AOXrZCTghIXkMInrGQZ8Ce
	9K54VTi8OhJDwIpFqfeaP0nMWLYMb+e0utmO+J5o+4+JZh8Bed2a3IuPnSOtioIkawmK
	CYngyqzPms5k3SLDwRb4h1SLzVah3Q6oih5fbjW7RvmmI/dZyujYi1MZCqh4L9fbeHvd
	bucN3L0y6d6tX4RDa+QE+TTlfGW9J4cmk+WpoZjh0gePAD6EvScWZYcueVypF4ytJ4Mg
	PrMQ==
X-Gm-Message-State: AJcUukegpMikrx2FFwvbkhMKZ0yyQ/wmMKZQc0J/pjWqlQxE1XKx/P+1
	V7Fcv7j19tNH6+G3HgbjKcWj9A==
X-Google-Smtp-Source: ALg8bN5Ct4Uj1QrGyVqbEIG46iXe1IC+ropRks9HwSsknUrcFadn2S+XT1076bM2YBJ217PMRLngxA==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr49262503wrt.209.1546858291917;
	Mon, 07 Jan 2019 02:51:31 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o81sm12861633wmd.10.2019.01.07.02.51.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 02:51:31 -0800 (PST)
Message-ID: <5aec5b6835f59a4587f25bb129075c3a36faca66.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Krystian =?UTF-8?Q?Garli=C5=84ski?= <krystian.garlinski@comarch.pl>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 07 Jan 2019 10:51:30 +0000
In-Reply-To: <20181220102314.24543-1-krystian.garlinski@comarch.pl>
References: <20181220102314.24543-1-krystian.garlinski@comarch.pl>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2/gitsm.py: Change the URI construction logic
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
X-List-Received-Date: Mon, 07 Jan 2019 10:51:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-12-20 at 11:23 +0100, Krystian Garliński wrote:
> Git allows to use both the proper URI's and SCP-like short style
> syntax
> for the SSH protocol. This commit changes construction logic to
> detect which
> one of the two is used in the submodule specification and to build a
> correct
> URI out of it.
> 
> Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl>
> ---
>  lib/bb/fetch2/gitsm.py | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

This causes bitbake-selftest to fail:

$ bitbake-selftest
..................................................................................................................................................................................................................................................................................................................E
Stdout:
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 ls-remote file:///tmp/tmp96d_f_w2/gitsource 
Trying PREMIRRORS
Trying Upstream
Running export PSEUDO_DISABLED=1; LANG=C git -c core.fsyncobjectfiles=0 clone --bare --mirror /tmp/tmp96d_f_w2/gitsource /tmp/tmp96d_f_w2/download/git2/tmp.tmp96d_f_w2.gitsource --progress
Cloning into bare repository '/tmp/tmp96d_f_w2/download/git2/tmp.tmp96d_f_w2.gitsource'...
done.
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 branch --contains b9f67d0efd04c6a57ac03c7b76166d76e2b46972 --list master 2> /dev/null | wc -l
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 branch --contains b9f67d0efd04c6a57ac03c7b76166d76e2b46972 --list master 2> /dev/null | wc -l
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 show b9f67d0efd04c6a57ac03c7b76166d76e2b46972:.gitmodules
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 ls-tree -z -d b9f67d0efd04c6a57ac03c7b76166d76e2b46972 gitsubmodule
Failed to fetch URL gitsm:///tmp/tmp96d_f_w2/gitsource;protocol=file;subdir=/tmp/tmp96d_f_w2/git, attempting MIRRORS if available
The URL: 'gitsm:/tmp/tmp96d_f_w2/gitsubmodule;protocol=file;name=gitsubmodule;bareclone=1;nocheckout=1;nobranch=1' is invalid and cannot be interpreted
Trying MIRRORS
The URL: 'gitsm:/tmp/tmp96d_f_w2/gitsubmodule;protocol=file;name=gitsubmodule;bareclone=1;nocheckout=1;nobranch=1' is invalid and cannot be interpreted
...........................................................................
======================================================================
ERROR: test_shallow_submodules (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/media/build1/poky/bitbake/lib/bb/tests/fetch.py", line 1476, in test_shallow_submodules
    fetcher, ud = self.fetch_shallow(uri)
  File "/media/build1/poky/bitbake/lib/bb/tests/fetch.py", line 1305, in fetch_shallow
    fetcher, ud = self.fetch_and_unpack(uri)
  File "/media/build1/poky/bitbake/lib/bb/tests/fetch.py", line 1298, in fetch_and_unpack
    fetcher, ud = self.fetch(uri)
  File "/media/build1/poky/bitbake/lib/bb/tests/fetch.py", line 1293, in fetch
    fetcher.download()
  File "/media/build1/poky/bitbake/lib/bb/fetch2/__init__.py", line 1714, in download
    raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'gitsm:///tmp/tmp96d_f_w2/gitsource;protocol=file;subdir=/tmp/tmp96d_f_w2/git'. Unable to fetch URL from any source.

Stdout:
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 ls-remote file:///tmp/tmp96d_f_w2/gitsource 
Trying PREMIRRORS
Trying Upstream
Running export PSEUDO_DISABLED=1; LANG=C git -c core.fsyncobjectfiles=0 clone --bare --mirror /tmp/tmp96d_f_w2/gitsource /tmp/tmp96d_f_w2/download/git2/tmp.tmp96d_f_w2.gitsource --progress
Cloning into bare repository '/tmp/tmp96d_f_w2/download/git2/tmp.tmp96d_f_w2.gitsource'...
done.
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 branch --contains b9f67d0efd04c6a57ac03c7b76166d76e2b46972 --list master 2> /dev/null | wc -l
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 branch --contains b9f67d0efd04c6a57ac03c7b76166d76e2b46972 --list master 2> /dev/null | wc -l
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 show b9f67d0efd04c6a57ac03c7b76166d76e2b46972:.gitmodules
Running export PSEUDO_DISABLED=1; git -c core.fsyncobjectfiles=0 ls-tree -z -d b9f67d0efd04c6a57ac03c7b76166d76e2b46972 gitsubmodule
Failed to fetch URL gitsm:///tmp/tmp96d_f_w2/gitsource;protocol=file;subdir=/tmp/tmp96d_f_w2/git, attempting MIRRORS if available
The URL: 'gitsm:/tmp/tmp96d_f_w2/gitsubmodule;protocol=file;name=gitsubmodule;bareclone=1;nocheckout=1;nobranch=1' is invalid and cannot be interpreted
Trying MIRRORS
The URL: 'gitsm:/tmp/tmp96d_f_w2/gitsubmodule;protocol=file;name=gitsubmodule;bareclone=1;nocheckout=1;nobranch=1' is invalid and cannot be interpreted

----------------------------------------------------------------------
Ran 382 tests in 477.872s

FAILED (errors=1)


