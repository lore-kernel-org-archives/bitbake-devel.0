Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id AA48A774D8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 10:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 4EB841EF7BBD
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 12:44:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id vp+hxgKt6xXA for <bitbake-devel@lists.openembedded.org>; 
	Tue,  6 Sep 2016 12:44:12 +0200 (CEST)
Received: from [10.9.18.228] (246.105.204.77.rev.sfr.net [77.204.105.246])
	by idris.smile.fr (Postfix) with ESMTPSA id F2C5E1EF7BB5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 12:44:11 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <0c15d6b9-0664-3ff3-710d-c0ca940a4412@smile.fr>
Date: Tue, 6 Sep 2016 12:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
Subject: Re: [PATCH v2 0/1][resend] Add a syntax to unset variable from bitbake configuration file
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
X-List-Received-Date: Tue, 06 Sep 2016 10:44:13 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Any news ?


On 23/08/2016 11:44, Jérémy Rosen wrote:
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


