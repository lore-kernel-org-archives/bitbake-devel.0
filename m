Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E917B61222
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2013 11:26:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7CBbTJP022164; Mon, 12 Aug 2013 12:37:29 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CemZJ70jvOa6; Mon, 12 Aug 2013 12:37:29 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7CBbN6b022153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 12 Aug 2013 12:37:25 +0100
Message-ID: <1376306776.27470.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 12 Aug 2013 12:26:16 +0100
In-Reply-To: <1376210197-10265-1-git-send-email-Martin.Jansa@gmail.com>
References: <1376210197-10265-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC] WIP: git: prefix with refs/tags/ when revision isn't git hash
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
X-List-Received-Date: Mon, 12 Aug 2013 11:26:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2013-08-11 at 10:36 +0200, Martin Jansa wrote:
> * many Open webOS components have tag in format
>   submissions/N, versions/X.Y.Z
>   just by chance I've noticed that git ls-remote behaves a bit different
>   than what I've expected:
> 
>   We were using tag=18 in SRC_URI.
>   librolegen repository doesn't have tag '18'
>   $ git tag -l
>   submissions/0
>   submissions/16
>   submissions/17
>   submissions/18
>   version/2.0.0
>   versions/2.1.0
> 
>   It was working correctly until now, just because we were lucky.
> 
>   From git help ls-remote:
>     When <refs>... are specified, only references matching the given
>     patterns are displayed.
>   $ git ls-remote git://github.com/openwebos/librolegen 18
>     cbedc69733f65cd2f498787a621c014e219d38ab        refs/tags/submissions/18
>   $ git ls-remote git://github.com/openwebos/librolegen 17
>     af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/submissions/17
>   $ git ls-remote git://github.com/openwebos/librolegen
>     9040954a24115b05219e7dd459dcf91ad05cc739        HEAD
>     9040954a24115b05219e7dd459dcf91ad05cc739        refs/heads/master
>     85524970dba46557d3c9672455a4a88165efe7f1        refs/notes/review
>     fe509e33f5d68c834bce087dff0f6c801d869b68        refs/tags/submissions/0
>     04bc2c24ce628de3ac0fba8afce088f2391f96bb        refs/tags/submissions/0^{}
>     7aa394eea6bd76618337772894f7615d0ae8e13a        refs/tags/submissions/16
>     af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/submissions/17
>     cbedc69733f65cd2f498787a621c014e219d38ab        refs/tags/submissions/18
>     9040954a24115b05219e7dd459dcf91ad05cc739        refs/tags/submissions/18^{}
>     7aa394eea6bd76618337772894f7615d0ae8e13a        refs/tags/version/2.0.0
>     af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/versions/2.1.0
> 
>     So if someone creates tag 'foo/18' ls-remote will return both lines and
>     build will fail.
> 
>     Prefixing with 'refs/tags/' will work in this case, but I haven't tested
>     if this code breaks AUTOREV or other use-cases -> that's why it's RFC + WIP.
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 6175e4c..ebb5722 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -124,7 +124,7 @@ class Git(FetchMethod):
>              # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
>              if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
>                  if ud.revisions[name]:
> -                    ud.branches[name] = ud.revisions[name]
> +                    ud.branches[name] = "refs/tags/%s" % ud.revisions[name]
>                  ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
>  
>          gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))

This may need to test "refs/heads/%s" before checking "refs/tags/%s"
since a head name or tag name are currently equally accepted in
revisions.

Also, what if ud.branches was already set to something, shouldn't we
error in that case? (I appreciate you haven't introduced that issue).

Cheers,

Richard


