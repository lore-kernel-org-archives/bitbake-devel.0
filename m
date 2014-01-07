Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 307416C744
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 13:38:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07Dcgox002516; Tue, 7 Jan 2014 13:38:42 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lHjVadccl_mw; Tue,  7 Jan 2014 13:38:42 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07DcXSu002498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 13:38:34 GMT
Message-ID: <1389101908.6899.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Gherzan <andrei@gherzan.ro>
Date: Tue, 07 Jan 2014 13:38:28 +0000
In-Reply-To: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Tue, 07 Jan 2014 13:38:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2014-01-05 at 03:53 +0200, Andrei Gherzan wrote:
> When getting the revision we must take into consideration if the name we are
> looking for is a tag and in that case we need the dereferenced commit ID in
> order to check for it existance in a specific branch.
> 
> So first search for the reference^{} commit ID and only if that returns nothing
> get the name as it is.

In what case would reference^{} fail to work when reference would?
Reading the git documentation, I'm struggling to see a case when ^{}
wouldn't do the right thing and if that is the case we don't need the
fallback?

Cheers,

Richard

> Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
> ---
>  bitbake/lib/bb/fetch2/git.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index b4b9368..1584232 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -318,9 +318,13 @@ class Git(FetchMethod):
>                (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
>          if ud.proto.lower() != 'file':
>              bb.fetch2.check_network_access(d, cmd)
> -        output = runfetchcmd(cmd, d, True)
> +        # Maybe the ref is a tag so try to dereference it first
> +        output = runfetchcmd(cmd + '^{}', d, True)
>          if not output:
> -            raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
> +            # Dereference gave nothing so try to get it as it is
> +            output = runfetchcmd(cmd, d, True)
> +            if not output:
> +                raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
>          return output.split()[0]
>  
>      def _build_revision(self, ud, d, name):



