Return-Path: <zboszor@pr.hu>
Received: from mail7.pr.hu (mail7.pr.hu [87.242.0.7])
	by mail.openembedded.org (Postfix) with ESMTP id 87E216FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 08:55:59 +0000 (UTC)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <zboszor@pr.hu>)
	id 1enhEu-0002OU-KF; Mon, 19 Feb 2018 09:56:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
	s=pr20170203; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3S9xaxHvw6HzK/FqjPw8St3EsiWs+eNwgORTnoXBjs4=;
	b=TVbTUVPeO1Vz6xHf/A6l1uZAu0
	wt9UeEJdUaSMjqt22T0bsGk6M/w6M7eE/T/xXj6odthV27fWFBI6wrCXt5kM30UAsvQ8HtiOaruMg
	SO/WMHdgR03loeaV8gnIUnkt5pIp4irqfNqiQqjGiEnsGD61hrOl592x2snCUE1keiAr8k7FHrJpb
	39Kwyf88YqShswb+PsnWH8YVLO6gTKjn2agGzcDYAVb31SUEZkVRD3UxKWhsEWVwVhKvjjptRzI3T
	yxVr3BvlQN3qL0fTUJ8ieve3Q+m242BMh0VTML6bWssQixhzGYY24vZlgzOtYx79TH2GuhMWFr0jI
	f55wifMg==;
Received: from host-87-242-32-111.prtelecom.hu ([87.242.32.111]
	helo=s002.sicom.com)
	by mail.pr.hu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89) (envelope-from <zboszor@pr.hu>)
	id 1enhEq-000707-Co; Mon, 19 Feb 2018 09:55:58 +0100
To: mpvader <mvader@victronenergy.com>, bitbake-devel@lists.openembedded.org
References: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Message-ID: <82bcf115-965e-60fb-ed35-a116cabce937@pr.hu>
Date: Mon, 19 Feb 2018 09:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
X-Spam-Score: 0.5 (/)
X-Scan-Signature: 58ab21d751055c5f434a9dd5a96062a4
X-Spam-Tracer: backend.mail.pr.hu 0.5 20180219085558Z
Subject: Re: [PATCH] fetch2/npm: fix parsing multiple matching packages
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
X-List-Received-Date: Mon, 19 Feb 2018 08:55:59 -0000
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

2018-02-11 23:31 keltezéssel, mpvader írta:
> Replace the self-implemented parser with loading the complete json and then
> taking the last element from it.
> 
> This fixes an error fetching the lex-parser package, as a dependency of, for
> example, jison. Reproduce the error with this command:
> 
> devtool add "npm://registry.npmjs.org;name=jison;version=0.4.18"
> 
> _parse_view() didn't properly parse the npm view result [1], resulting in
> an Exception in the subsequent json.loads() function:
> Exception: ValueError: Extra data: line 57 column 4 - line 296 column 2 (char 5874 - 29698)

I can confirm this problem exists in Bitbake 1.36 and goes away with the patch.

Also tested the patch for the handful of node module recipes
I have and they still build properly.

> 
> [1] npm view lex-parser@'0.1.x' --json --registry http://registry.npmjs.org
> 
> Signed-off-by: mpvader <mvader@victronenergy.com>

Tested-by: Zoltán Böszörményi <zboszor@pr.hu>

> ---
>   lib/bb/fetch2/npm.py | 29 ++++++++---------------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index b5f148c..e257355 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -146,25 +146,6 @@ class Npm(FetchMethod):
>   
>           self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
>   
> -    def _parse_view(self, output):
> -        '''
> -        Parse the output of npm view --json; the last JSON result
> -        is assumed to be the one that we're interested in.
> -        '''
> -        pdata = None
> -        outdeps = {}
> -        datalines = []
> -        bracelevel = 0
> -        for line in output.splitlines():
> -            if bracelevel:
> -                datalines.append(line)
> -            elif '{' in line:
> -                datalines = []
> -                datalines.append(line)
> -            bracelevel = bracelevel + line.count('{') - line.count('}')
> -        if datalines:
> -            pdata = json.loads('\n'.join(datalines))
> -        return pdata
>   
>       def _getdependencies(self, pkg, data, version, d, ud, optional=False, fetchedlist=None):
>           if fetchedlist is None:
> @@ -175,9 +156,15 @@ class Npm(FetchMethod):
>           logger.debug(2, "Calling getdeps on %s" % pkg)
>           fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
>           output = runfetchcmd(fetchcmd, d, True)
> -        pdata = self._parse_view(output)
> -        if not pdata:
> +        if not output:
>               raise FetchError("The command '%s' returned no output" % fetchcmd)
> +        pdata = json.loads(output)
> +
> +        # npm registry will return multiple dicts in a list when there is more than one matching
> +        # version. Take the last one.
> +        if isinstance(pdata, list):
> +            pdata = pdata[-1]
> +
>           if optional:
>               pkg_os = pdata.get('os', None)
>               if pkg_os:
> 


