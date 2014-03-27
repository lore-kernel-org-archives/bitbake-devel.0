Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 123386E8A6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 03:25:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s2R3PLKF014835
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 26 Mar 2014 20:25:21 -0700 (PDT)
Received: from [128.224.162.226] (128.224.162.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Wed, 26 Mar 2014 20:25:21 -0700
Message-ID: <53339A1F.4050907@windriver.com>
Date: Thu, 27 Mar 2014 11:25:19 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1395802560.git.liezhi.yang@windriver.com>	
	<6d78004e5ccfd737bac24e5346d079aab11df2e7.1395802560.git.liezhi.yang@windriver.com>
	<1395828299.24890.85.camel@ted>
In-Reply-To: <1395828299.24890.85.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Thu, 27 Mar 2014 03:25:26 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 03/26/2014 06:04 PM, Richard Purdie wrote:
> On Wed, 2014-03-26 at 05:27 -0400, Robert Yang wrote:
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> When specifying tags, they're searched for unanchored so foo/bar could
>> match:
>>
>> refs/heads/abc/foo/bar
>> refs/heads/xyz/foo/bar
>> refs/heads/foo/bar
>>
>> This change anchors the expressions so they are based against heads
>> or tags (or any other base level tree that has been created).
>>
>> (Bitbake master rev: df2e0972cd1db7abd5ec8b7cb295fb0c42e284a4)
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> Conflicts:
>> 	bitbake/lib/bb/fetch2/git.py
>> 	(ud.basecmd and basecmd conflicts, keep using basecmd)
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index 6175e4c..cff5ce1 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -305,8 +305,8 @@ class Git(FetchMethod):
>>               username = ""
>>
>>           basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
>> -        cmd = "%s ls-remote %s://%s%s%s %s" % \
>> -              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
>> +        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
>> +              (basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])
>
> Shouldn't this be ud.branches[name] for dora?
>

OOPS, thanks, I've updated the patch:

git://git.pokylinux.org/poky-contrib robert/dora-next
http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/dora-next

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 6175e4c..989d72c 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -305,8 +305,8 @@ class Git(FetchMethod):
              username = ""

          basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
+        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
+              (basecmd, ud.proto, username, ud.host, ud.path, 
ud.branches[name], ud.branches[name])
          if ud.proto.lower() != 'file':
              bb.fetch2.check_network_access(d, cmd)
          output = runfetchcmd(cmd, d, True)

// Robert


> Cheers,
>
> Richard
>
>
>

