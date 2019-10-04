Return-Path: <zboszor@pr.hu>
X-Greylist: delayed 619 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 04 Oct 2019 06:09:24 UTC
Received: from mail9.pr.hu (mail9.pr.hu [87.242.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id F24146C3AA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2019 06:09:24 +0000 (UTC)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <zboszor@pr.hu>)
	id 1iGGcJ-00051b-EJ; Fri, 04 Oct 2019 07:59:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
	s=pr20170203; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZmlIzDlgQgBB4Htf32esVUCuk6tmbKHh7II3IHXqdO4=;
	b=WAIvu6sTqYFVQvkfSDoUrg7/+0
	QvC8azsLai05oJ3Tl8EVSn1E1KZscHwQvOFfHJiQ4l8N5ZK7odak6WbZAND4niaTDBXV23xzl1vgO
	T5oUEWQlKQY7xs03a2ENQw7uTs/o9UgLJa131pr4hdUIP0UNI/Wenhtbb/WXhVeugl7vWQCxK1kbU
	VHiCcZFNh//HMqUvHPaRQMyXjAJKgOcRsX1TPwogNpW8+7+r3rSKDaTJ/Ny44ka3EOvRxKm1NXiwQ
	GdgXgo+3QC1vOSH9U+GJ8zd10gQCIveeRURfjKoFed6BH5fI6Hs5ioQGQ4MZnE3I9OoaMjxW/9RaZ
	x4Sd/AzQ==;
Received: from host-87-242-20-26.prtelecom.hu ([87.242.20.26]
	helo=[192.168.1.13])
	by mail.pr.hu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89) (envelope-from <zboszor@pr.hu>)
	id 1iGGcF-0002YM-2B; Fri, 04 Oct 2019 07:59:01 +0200
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
To: mpvader <mvader@victronenergy.com>, bitbake-devel@lists.openembedded.org
References: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
	<82bcf115-965e-60fb-ed35-a116cabce937@pr.hu>
Message-ID: <2b4588c7-adff-5a12-2cb7-c1b3be1eeb74@pr.hu>
Date: Fri, 4 Oct 2019 07:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <82bcf115-965e-60fb-ed35-a116cabce937@pr.hu>
X-Spam-Score: -1.8 (-)
X-Scan-Signature: dbe59d53eea3b47fe6629620c210aed7
X-Spam-Tracer: backend.mail.pr.hu -1.8 20191004055901Z
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
X-List-Received-Date: Fri, 04 Oct 2019 06:09:25 -0000
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Bitbake devs!

The exception with the below "devtool add ..." command still occurs with
bvitbake 1.42.0 used in Yocto 2.7 and is fixed with the patch.

Please consider applying/backporting it.

Best regards,
Zoltán Böszörményi

2018. 02. 19. 9:55 keltezéssel, Böszörményi Zoltán írta:
> 2018-02-11 23:31 keltezéssel, mpvader írta:
>> Replace the self-implemented parser with loading the complete json and then
>> taking the last element from it.
>>
>> This fixes an error fetching the lex-parser package, as a dependency of, for
>> example, jison. Reproduce the error with this command:
>>
>> devtool add "npm://registry.npmjs.org;name=jison;version=0.4.18"
>>
>> _parse_view() didn't properly parse the npm view result [1], resulting in
>> an Exception in the subsequent json.loads() function:
>> Exception: ValueError: Extra data: line 57 column 4 - line 296 column 2 (char 5874 - 29698)
> 
> I can confirm this problem exists in Bitbake 1.36 and goes away with the patch.
> 
> Also tested the patch for the handful of node module recipes
> I have and they still build properly.
> 
>>
>> [1] npm view lex-parser@'0.1.x' --json --registry http://registry.npmjs.org
>>
>> Signed-off-by: mpvader <mvader@victronenergy.com>
> 
> Tested-by: Zoltán Böszörményi <zboszor@pr.hu>
> 
>> ---
>>   lib/bb/fetch2/npm.py | 29 ++++++++---------------------
>>   1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index b5f148c..e257355 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -146,25 +146,6 @@ class Npm(FetchMethod):
>>           self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
>> -    def _parse_view(self, output):
>> -        '''
>> -        Parse the output of npm view --json; the last JSON result
>> -        is assumed to be the one that we're interested in.
>> -        '''
>> -        pdata = None
>> -        outdeps = {}
>> -        datalines = []
>> -        bracelevel = 0
>> -        for line in output.splitlines():
>> -            if bracelevel:
>> -                datalines.append(line)
>> -            elif '{' in line:
>> -                datalines = []
>> -                datalines.append(line)
>> -            bracelevel = bracelevel + line.count('{') - line.count('}')
>> -        if datalines:
>> -            pdata = json.loads('\n'.join(datalines))
>> -        return pdata
>>       def _getdependencies(self, pkg, data, version, d, ud, optional=False, 
>> fetchedlist=None):
>>           if fetchedlist is None:
>> @@ -175,9 +156,15 @@ class Npm(FetchMethod):
>>           logger.debug(2, "Calling getdeps on %s" % pkg)
>>           fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
>>           output = runfetchcmd(fetchcmd, d, True)
>> -        pdata = self._parse_view(output)
>> -        if not pdata:
>> +        if not output:
>>               raise FetchError("The command '%s' returned no output" % fetchcmd)
>> +        pdata = json.loads(output)
>> +
>> +        # npm registry will return multiple dicts in a list when there is more than one 
>> matching
>> +        # version. Take the last one.
>> +        if isinstance(pdata, list):
>> +            pdata = pdata[-1]
>> +
>>           if optional:
>>               pkg_os = pdata.get('os', None)
>>               if pkg_os:
>>
> 


