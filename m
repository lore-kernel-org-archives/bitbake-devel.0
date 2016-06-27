Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 81A8070016
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2016 18:19:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u5RIJmel003181
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2016 11:19:48 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.230) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Mon, 27 Jun 2016 11:19:47 -0700
To: Robert Yang <liezhi.yang@windriver.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
	<ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <d81d4085-5f4e-8f51-035a-b1f2570ff644@windriver.com>
Date: Mon, 27 Jun 2016 13:19:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Mon, 27 Jun 2016 18:19:48 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit

Based on some feedback on IRC.  I tried to move this into the git.py
'urldata_init' function.

This was pretty simple and appeared to work on the surface.  I then added a test
case to the fetch.py test cases.  At which point I can not reconcile the work.

In the test harness, around line 296 -- 'def test_uri', the system compares the
input URI, to the generated URI, i.e.:

        "git://example.net/path/example/": {
            'uri': 'git://example.net/path/example',
            'scheme': 'git',
            ...

The URI function and the fetch processing run two different paths.  Since the
URI class has no concept of special processing, the 'uri' it ends up with is
always "git://example.net/path/example/".  However, the fetchers processing,
after stripping the trailing '/' from the ud.path and then reconstructing the
URI ends up with "git://example.net/path/example".  And a test case failure I
can't get around.

So I have a couple of questions:

1) Why do we have both a URI and encodeurl/decodeurl set of functions?  It seems
like we have multiple ways of getting exactly the same data.

2) Is there a flaw in this test harness, that it verifies that element 1 and
element 2:uri always have to match?

The commit that highlights this issue is available as:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=mgh/bitbake-git&id=5e45f3dea413f5b95fd8a872d48b72c11df15680

--Mark

On 6/24/16 2:55 AM, Robert Yang wrote:
> From: Jason Wessel <jason.wessel@windriver.com>
> 
> The filename can't be "foo." for MS Windows filesystem, it will renamed
> to "foo" automatically, so we can't upload sources like "foo." to the
> Windows server, remove "." in the end will fix the problem.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 2 ++
>  bitbake/lib/bb/fetch2/git.py      | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index b6fcaaa..1633c81 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -865,6 +865,8 @@ def build_mirroruris(origud, mirrors, ld):
>      replacements["PATH"] = origud.path
>      replacements["BASENAME"] = origud.path.split("/")[-1]
>      replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
> +    if replacements["MIRRORNAME"].endswith('.'):
> +        replacements["MIRRORNAME"] = replacements["MIRRORNAME"][:-1]
>  
>      def adduri(ud, uris, uds, mirrors):
>          for line in mirrors:
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 59827e3..e669efc 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -142,6 +142,8 @@ class Git(FetchMethod):
>          gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
>          if gitsrcname.startswith('.'):
>              gitsrcname = gitsrcname[1:]
> +        if gitsrcname.endswith('.'):
> +            gitsrcname = gitsrcname[:-1]
>  
>          # for rebaseable git repo, it is necessary to keep mirror tar ball
>          # per revision, so that even the revision disappears from the
> 


