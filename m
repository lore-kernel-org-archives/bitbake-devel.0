Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfBF9-0007s4-NU
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 16:41:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5EEVC7k018806
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 14 Jun 2012 07:31:12 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 07:31:12 -0700
Message-ID: <4FD9F5AF.10905@windriver.com>
Date: Thu, 14 Jun 2012 09:31:11 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
	<1339643381-23026-5-git-send-email-jason.wessel@windriver.com>
	<1339679039.24333.76.camel@ted> <4FD9E81D.6030808@windriver.com>
	<1339683993.24333.81.camel@ted>
In-Reply-To: <1339683993.24333.81.camel@ted>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] fetch2/git.py: Optimize clone fall back when it is local
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Jun 2012 14:41:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 06/14/2012 09:26 AM, Richard Purdie wrote:
> On Thu, 2012-06-14 at 08:33 -0500, Jason Wessel wrote:
>> On 06/14/2012 08:03 AM, Richard Purdie wrote:
>>> On Wed, 2012-06-13 at 22:09 -0500, Jason Wessel wrote:
>>>> A file:// url should use "clone -s" to greatly speed
>>>> up the clone in the case of a kernel when it is local.
>>>>
>>>> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
>>>> ---
>>>>  lib/bb/fetch2/git.py |    8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>>>> index 1ad9213..f5a3983 100644
>>>> --- a/lib/bb/fetch2/git.py
>>>> +++ b/lib/bb/fetch2/git.py
>>>> @@ -192,7 +192,13 @@ class Git(FetchMethod):
>>>>  
>>>>          # If the repo still doesn't exist, fallback to cloning it
>>>>          if not os.path.exists(ud.clonedir):
>>>> -            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
>>>> +            if repourl.startswith("file://"):
>>>> +                use_s = "-s"
>>>> +                repo = repourl[7:]
>>>> +            else:
>>>> +                use_s = ""
>>>> +                repo = repourl
>>>> +            clone_cmd = "%s clone %s --bare --mirror %s %s" % (ud.basecmd, use_s, repo, ud.clonedir)
>>>>              if ud.proto.lower() != 'file':
>>>>                  bb.fetch2.check_network_access(d, clone_cmd)
>>>>              runfetchcmd(clone_cmd, d)
> I think you can then simplify this to:
>
> @@ -192,7 +192,9 @@ class Git(FetchMethod):
>   
>          # If the repo still doesn't exist, fallback to cloning it
>          if not os.path.exists(ud.clonedir):
> -            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
> +            if repourl.startswith("file://"):
> +                repo = repourl[7:]
> +            clone_cmd = "%s clone -l --bare --mirror %s %s" % (ud.basecmd, repo, ud.clonedir)
>              if ud.proto.lower() != 'file':
>                  bb.fetch2.check_network_access(d, clone_cmd)
>              runfetchcmd(clone_cmd, d)
>  
>

That is fine with me, given that it does the same thing.

Jason.


