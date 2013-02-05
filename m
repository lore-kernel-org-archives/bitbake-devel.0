Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U2Ydk-00012F-SK
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Feb 2013 03:52:10 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r152aGPF009410
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 4 Feb 2013 18:36:16 -0800 (PST)
Received: from [128.224.162.186] (128.224.162.186) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Mon, 4 Feb 2013 18:36:15 -0800
Message-ID: <51107019.2070509@windriver.com>
Date: Tue, 5 Feb 2013 10:36:09 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1359948771.git.liezhi.yang@windriver.com>
	<9d21459877d1d94bdaff1cbe8ca4dd84f5f692fd.1359948771.git.liezhi.yang@windriver.com>
	<CABcZAN=g5073uzZ_nu4Q585_BXmEiSTDcjZwQs4RvWQVhde1eA@mail.gmail.com>
In-Reply-To: <CABcZAN=g5073uzZ_nu4Q585_BXmEiSTDcjZwQs4RvWQVhde1eA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] perforce.py: fix the perforce fetcher
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
X-List-Received-Date: Tue, 05 Feb 2013 02:52:11 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Chris,

Thank you very much, I've updated the pull request:

   git://git.pokylinux.org/poky-contrib robert/p4
   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/p4


diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index df3a3a3..fc4074d 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -170,7 +170,7 @@ class Perforce(FetchMethod):
          logger.info("Fetch " + loc)
          logger.info("%s%s files %s", p4cmd, p4opt, depot)
          p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
-        p4file = p4file.strip()
+        p4file = [f.rstrip() for f in p4file.splitlines()]

          if not p4file:
              raise FetchError("Fetch: unable to get the P4 files from %s" % 
depot, loc)

// Robert

On 02/04/2013 11:46 PM, Chris Larson wrote:
> On Mon, Feb 4, 2013 at 2:27 AM, Robert Yang <liezhi.yang@windriver.com>wrote:
>
>> The bb.process.run() will return one tuple, e.g:
>>
>> p4file = ('strA\nStrB\nstrC\n'), then there will be an iteration on p4file:
>>
>> for i in p4file:
>>          [snip]
>>
>> The i will be 's t r A ...', this is incorrect. use:
>>
>> p4file = p4file.splitlines()
>>
>> will fix the problem.
>>
>> [YOCTO #3619]
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/perforce.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/perforce.py
>> b/bitbake/lib/bb/fetch2/perforce.py
>> index df3a3a3..86ec9ba 100644
>> --- a/bitbake/lib/bb/fetch2/perforce.py
>> +++ b/bitbake/lib/bb/fetch2/perforce.py
>> @@ -170,7 +170,7 @@ class Perforce(FetchMethod):
>>           logger.info("Fetch " + loc)
>>           logger.info("%s%s files %s", p4cmd, p4opt, depot)
>>           p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt,
>> depot))
>> -        p4file = p4file.strip()
>> +        p4file = p4file.splitlines()
>>
>
> Note that splitlines doesn't chop off the trailing newlines from the
> individual strings. It *probably* wont cause an issue in this case due to
> how it's passed to the shell in the subsequent subprocess call, but from a
> correctness standpoint, I'd suggest changing this to something like p4files
> = [f.rstrip() for f in p4file.splitlines], or doing an rstrip on the
> individual files in the later iteration.
>


