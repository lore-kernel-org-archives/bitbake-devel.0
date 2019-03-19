Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3DBDB6BF38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 06:36:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2J6adfr009338
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 18 Mar 2019 23:36:40 -0700 (PDT)
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Mon, 18 Mar 2019 23:36:38 -0700
To: Mark Hatle <mark.hatle@windriver.com>, "Lisicki, Raphael"
	<raphael.lisicki@siemens.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
	<AM5PR10MB18437E4D46F44792D2685E9AEC4B0@AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM>
	<37078a74-86c7-39b2-6375-87b7f8fdb8a7@windriver.com>
	<d0f5f424-36b0-b266-f6cc-c5085cc39586@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <f3c170d1-b0db-fd6c-b00a-7e8b37990af8@windriver.com>
Date: Tue, 19 Mar 2019 14:41:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d0f5f424-36b0-b266-f6cc-c5085cc39586@windriver.com>
Subject: Re: [PATCH 4/5] fetch2/gitsm: Add clean function
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
X-List-Received-Date: Tue, 19 Mar 2019 06:36:44 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Mark,

On 3/15/19 11:44 PM, Mark Hatle wrote:
> On 3/14/19 9:50 PM, Robert Yang wrote:
>> Hi,
>>
>> On 3/14/19 8:34 PM, Lisicki, Raphael wrote:
>>> I have not fully understand the logic but I am wondering what happens here is a submodule is located in two different repositories? Wouldn't a clean of one module delete submodules of the other one as well?
>>
>> Here are more explanations about the logic, for example, repo_A has two
>> submodules repo_B and repo_C, then after do_fetch,
>> they will be"
>> DL_DIR/repo_A
>> DL_DIR/repo_B
>> DL_DIR/repo_C
>>
>> Without this patch, do_cleanall only removes DL_DIR/repo_A, but leaves
>> repo_B and repo_C there, this patch makes it remove repo_B and C.
> 
> The issue Raphael is mentioning is when you have multiple projects that use the
> same submodules.  I.e.:
> 
> recipeA:
>   DL_DIR/repo_A
>   DL_DIR/repo_B
>   DL_DIR/repo_C
> 
> recipeB:
>   DL_DIR/repo_D
>   DL_DIR/repo_C
> 
> If you do a clean of A, you will end up removing repo_C which both items end up
> using.
> 
> I don't know any way to resolve this, since the dependency is implicit, not
> explicit -- so the system won't have any idea that the same thing is used in
> multiple places.
> 
>>
>> For your question, if repo_B is submodule of both repo_A and repo_D, it
>> is like foo and foo-native use the same git source, when you run
>> "bitbake foo -cccleanall", both foo and foo-native's source will be
>> removed since they use the same source, the similar to gitsm, so it is not
>> a problem, the source will be re-downloaded automatically when needed.
> 
> I'm not sure if this situation will work, since the recipeB will have a stamp
> that says the download is complete, even though part of it is now missing.


It's a generic issue when the same sources are use across recipes, e.g.:

# Cleanup everything
$ bitbake gnu-config gnu-config-native -ccleanall

# Fetch
$ bitbake gnu-config gnu-config-native -cfetch

# Cleanup the git repo
$ bitbake gnu-config -ccleanall

# Unpack gnu-config-native
$ bitbake gnu-config-native -cunpack

ERROR: gnu-config-native-20181128+gitAUTOINC+058639be22-r0 do_unpack: Unpack 
failure for URL: 'git://git.savannah.gnu.org/config.git'. No up to date source 
found: clone directory not available or not up to date: 
/buildarea1/lyang1/rebase-work/test_fetch/downloads/git2/git.savannah.gnu.org.config.git; 
shallow clone not enabled
ERROR: gnu-config-native-20181128+gitAUTOINC+058639be22-r0 do_unpack:
ERROR: gnu-config-native-20181128+gitAUTOINC+058639be22-r0 do_unpack: Function 
failed: base_do_unpack

So the users should handle it themselves in such a case.

// Robert

> 
> --Mark
> 
>> // Robert
>>
>>>
>>> Best regards
>>> Raphael
>>>
>>>> -----Original Message-----
>>>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>>>> bounces@lists.openembedded.org> On Behalf Of Robert Yang
>>>> Sent: Thursday, March 14, 2019 10:28 AM
>>>> To: bitbake-devel@lists.openembedded.org
>>>> Subject: [bitbake-devel] [PATCH 4/5] fetch2/gitsm: Add clean function
>>>>
>>>> The git's clean can only remove parent git repo from DL_DIR, but doesn't
>>>> remove
>>>> submodules, this patch fixes the problem.
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>    bitbake/lib/bb/fetch2/gitsm.py | 15 +++++++++++++--
>>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
>>>> index b21fed2..bb61093 100644
>>>> --- a/bitbake/lib/bb/fetch2/gitsm.py
>>>> +++ b/bitbake/lib/bb/fetch2/gitsm.py
>>>> @@ -76,8 +76,8 @@ class GitSM(Git):
>>>>            for name in ud.names:
>>>>                try:
>>>>                    gitmodules = runfetchcmd("%s show %s:.gitmodules" %
>>>> (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
>>>> -            except:
>>>> -                # No submodules to update
>>>> +            except Exception as esc:
>>>> +                logger.info("No submodules found: %s" % workdir)
>>>>                    continue
>>>>
>>>>                for m, md in parse_gitmodules(gitmodules).items():
>>>> @@ -164,6 +164,17 @@ class GitSM(Git):
>>>>            Git.download(self, ud, d)
>>>>            self.process_submodules(ud, ud.clonedir, download_submodule, d)
>>>>
>>>> +    def clean(self, ud, d):
>>>> +        def clean_submodule(ud, url, module, modpath, d):
>>>> +            try:
>>>> +                newfetch = Fetch([url], d, cache=False)
>>>> +                newfetch.clean()
>>>> +            except Exception as e:
>>>> +                logger.warn('gitsm: submodule clean failed: %s %s' %
>>>> (type(e).__name__, str(e)))
>>>> +
>>>> +        self.process_submodules(ud, ud.clonedir, clean_submodule, d)
>>>> +        Git.clean(self, ud, d)
>>>> +
>>>>        def unpack(self, ud, destdir, d):
>>>>            def unpack_submodules(ud, url, module, modpath, d):
>>>>                url += ";bareclone=1;nobranch=1"
>>>> --
>>>> 2.7.4
>>>>
>>>> --
>>>> _______________________________________________
>>>> bitbake-devel mailing list
>>>> bitbake-devel@lists.openembedded.org
>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> 
> 

