Return-Path: <v.vogelhuber@digitalendoscopy.de>
X-Greylist: delayed 464 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 16 Nov 2017 17:36:01 UTC
Received: from mx-relay22-hz1.antispameurope.com
	(mx-relay22-hz1.antispameurope.com [94.100.132.222])
	by mail.openembedded.org (Postfix) with ESMTP id 5232A787B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Nov 2017 17:36:01 +0000 (UTC)
Received: from host-80-81-19-29.customer.m-online.net ([80.81.19.29]) by
	mx-relay22-hz1.antispameurope.com; Thu, 16 Nov 2017 18:28:18 +0100
Received: from DE028.digitendos.de (192.168.20.186) by srv-msx01.digitendos.de
	(192.168.20.14) with Microsoft SMTP Server (TLS) id 15.0.516.32;
	Thu, 16 Nov 2017 18:28:08 +0100
To: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
References: <20171116141541.5533-1-v.vogelhuber@digitalendoscopy.de>
	<20171116111928.17c27c0b@lsandov1-mobl2.zpn.intel.com>
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Message-ID: <5803d6c4-ad5d-fb29-7e1f-1e89907a5ead@digitalendoscopy.de>
Date: Thu, 16 Nov 2017 18:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171116111928.17c27c0b@lsandov1-mobl2.zpn.intel.com>
X-Originating-IP: [192.168.20.186]
X-ClientProxiedBy: srv-msx01.digitendos.de (192.168.20.14) To
	srv-msx01.digitendos.de (192.168.20.14)
X-TM-AS-Product-Ver: SMEX-11.1.0.1291-8.100.1062-23468.006
X-TM-AS-Result: No--20.032900-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-cloud-security-sender: v.vogelhuber@digitalendoscopy.de
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
	mx-relay22-hz1.antispameurope.com with C64E211C4801
X-cloud-security-connect: host-80-81-19-29.customer.m-online.net[80.81.19.29],
	TLS=1, IP=80.81.19.29
X-cloud-security: scantime:.1813
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix mercurial fetching (hosttools need hd for latest revision autoinc, fix username and password usage and setting moddir needed by setup_revisions)
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
X-List-Received-Date: Thu, 16 Nov 2017 17:36:01 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Sorry this was my first patch sent with git send-mail. Seems like I had 
to learn how to properly compose an email out of it.

Regarding the patch:
I just tried updating my existing yocto toolchain to rocko and our 
recipes using mercurial repositories failed during parsing. We're using 
a Mercurial repository for our internal stuff and also the AUTOREV 
feature. So during parsing the revision in the recipes the call to 
/usr/bin/env hg failed because it is not part of the HOSTTOOLS. As it 
seems like bitbake is now replacing the PATH environment variable a 
mercurial installation on the host system is not found anymore. I saw 
that there seem to be some automatic dependency check which results in a 
dependency to mercurial-native, but as far as I analyzed it, this comes 
too late for the revision parsing as mercurial has to be available 
already for that case. That's why I added hg to HOSTTOOLS_NONFATAL which 
results in the automatic creation of a symbol link in the HOSTTOOLS_DIR 
which solves the problem.
The second thing is that the setup_revisions call will access ud.moddir 
which is not yet set in the current implementation. That's why I moved 
it to the lines below ud.basecmd where ud.moddir has been set already.
And the third thing is that username and password were not taken into 
account during unpack. Thats why I added it.

Kind regards
    Volker

On 16.11.2017 18:19, Leonardo Sandoval wrote:
> 
> subject should be shorter answering the 'what this patch does' and the description the 'why this is needed'
> 
> 
> On Thu, 16 Nov 2017 15:15:41 +0100
> Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de> wrote:
> 
>> Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
>> ---
>>   bitbake/lib/bb/fetch2/hg.py | 27 +++++++++++++++++----------
>>   meta/conf/bitbake.conf      |  2 ++
>>   2 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
>> index d0857e63f7..04620f3722 100644
>> --- a/bitbake/lib/bb/fetch2/hg.py
>> +++ b/bitbake/lib/bb/fetch2/hg.py
>> @@ -66,13 +66,6 @@ class Hg(FetchMethod):
>>           else:
>>               ud.proto = "hg"
>>   
>> -        ud.setup_revisions(d)
>> -
>> -        if 'rev' in ud.parm:
>> -            ud.revision = ud.parm['rev']
>> -        elif not ud.revision:
>> -            ud.revision = self.latest_revision(ud, d)
>> -
>>           # Create paths to mercurial checkouts
>>           hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
>>                               ud.host, ud.path.replace('/', '.'))
>> @@ -86,6 +79,13 @@ class Hg(FetchMethod):
>>           ud.localfile = ud.moddir
>>           ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
>>   
>> +        ud.setup_revisions(d)
>> +
>> +        if 'rev' in ud.parm:
>> +            ud.revision = ud.parm['rev']
>> +        elif not ud.revision:
>> +            ud.revision = self.latest_revision(ud, d)
>> +
>>           ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS")
>>   
>>       def need_update(self, ud, d):
>> @@ -151,7 +151,7 @@ class Hg(FetchMethod):
>>                   cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
>>               else:
>>                   cmd = "%s pull" % (ud.basecmd)
>> -        elif command == "update":
>> +        elif command == "update" or command == "up":
>>               if ud.user and ud.pswd:
>>                   cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
>>               else:
>> @@ -259,12 +259,19 @@ class Hg(FetchMethod):
>>   
>>           scmdata = ud.parm.get("scmdata", "")
>>           if scmdata != "nokeep":
>> +            proto = ud.parm.get('protocol', 'http')
>>               if not os.access(os.path.join(codir, '.hg'), os.R_OK):
>>                   logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
>>                   runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
>>               logger.debug(2, "Unpack: updating source in '" + codir + "'")
>> -            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
>> -            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
>> +            if ud.user and ud.pswd:
>> +                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull %s" % (ud.basecmd, ud.user, ud.pswd, proto, ud.moddir), d, workdir=codir)
>> +            else:
>> +                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
>> +            if ud.user and ud.pswd:
>> +                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" up -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, revflag), d, workdir=codir)
>> +            else:
>> +                runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
>>           else:
>>               logger.debug(2, "Unpack: extracting source to '" + codir + "'")
>>               runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
>> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
>> index 9696273acc..9ec527228b 100644
>> --- a/meta/conf/bitbake.conf
>> +++ b/meta/conf/bitbake.conf
>> @@ -494,6 +494,8 @@ HOSTTOOLS_NONFATAL += "join nl size yes zcat"
>>   
>>   # Used by bzr fetcher
>>   HOSTTOOLS_NONFATAL += "bzr"
>> +# Used by hg fetcher
>> +HOSTTOOLS_NONFATAL += "hg"
>>   
>>   CCACHE ??= ""
>>   # ccache < 3.1.10 will create CCACHE_DIR on startup even if disabled, and
>> -- 
>> 2.11.0
>>
>> -- 
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

