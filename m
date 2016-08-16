Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id D4F15700F0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 13:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 3BDBD1EE051D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 15:15:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id 7h4NmmVBCp-N for <bitbake-devel@lists.openembedded.org>; 
	Tue, 16 Aug 2016 15:15:38 +0200 (CEST)
Received: from [10.1.8.214] (gre92-5-82-237-199-7.fbx.proxad.net
	[82.237.199.7])
	by idris.smile.fr (Postfix) with ESMTPSA id 15F7E1EE0875
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 15:15:37 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <cover.f65a7c2b6ae08fbad3e423dd6b23367d5039f196.1471349005.git-series.jeremy.rosen@smile.fr>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <b816f7df-8b74-c23d-78e5-ea0906432889@smile.fr>
Date: Tue, 16 Aug 2016 15:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.f65a7c2b6ae08fbad3e423dd6b23367d5039f196.1471349005.git-series.jeremy.rosen@smile.fr>
Subject: Re: [PATCH v2 0/1] Content-Transfer-Encoding: 8bit
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
X-List-Received-Date: Tue, 16 Aug 2016 13:15:42 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Wrong title, sorry about that

i'll fix that with V3 if needed... and i'll learn to use my tools, sorry 
about that


On 16/08/2016 14:04, Jérémy Rosen wrote:
> While working on a Yocto project I had a need to reactivate a task that was
> disabled (do_fetch[noexec]="1") Currently, bitbake does not check the value
> of the noexec flag but only if the flag is set. The only way to unset a flag
> is to use an inline python syntax like the one below
>
> python () {
>     d.delVarFlag("do_fetch","noexec")
> }
>
> Using inline python to do something as simple as clearing a flag sounded too
> complicated to me so I added a new keyword "unset" to bitbake with the
> following syntax :
>
> unset VAR
>
> will call d.delVar("VAR")
>
> unset VAR[flag]
>
> will call d.delVarFlag("VAR","flag")
>
> Documentation has been updated accordingly
>
> ---
> v2 : fix some wording in documentation
>       add unit test
>
> Jérémy Rosen (1):
>    add a syntax to clear variable
>
>   bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 17 ++++-
>   bitbake/lib/bb/parse/ast.py                                      | 33 +++++++-
>   bitbake/lib/bb/parse/parse_py/ConfHandler.py                     | 12 +++-
>   bitbake/lib/bb/tests/parse.py                                    | 17 ++++-
>   4 files changed, 79 insertions(+), 0 deletions(-)
>


