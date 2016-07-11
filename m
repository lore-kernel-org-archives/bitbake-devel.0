Return-Path: <cliff.brake@gmail.com>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.161.195])
	by mail.openembedded.org (Postfix) with ESMTP id 92A8F60797
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jul 2016 14:15:48 +0000 (UTC)
Received: by mail-yw0-f195.google.com with SMTP id y188so8967872ywf.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jul 2016 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=goKBrOmQ+iUzL+57+pM/oUHvJsHo30XiOP3H4D5/ews=;
	b=AXYC6KvRK7IbFWIkEab8phgGFxilo2NX6xYKr2s47jokIQNERoNY6CCePyHRSPU9Df
	y92asTM+KE78Fxutv/ZiISgrGlOC8KDoCE3kgBwJBDvppHkuKVS/vbm2aGvUVNmapoWV
	YAUI6l+XRx/P3qbQsVM+aKW1rjFQ3swgHIxaVrlQgK8Q1ySKDWyL0ZvLmKNCPej/xkIN
	2shr6EZUJ3PHP+D2uf4HsCIPKz+M7NTN8vtSsG7PFBJtps4Nq1s9UzH9H+khaD5sFlCV
	BQvTKbzW7RowXixY81yEAI+y8b6zeZkRsukjLgHnxJs74RyfW3W/IDVVtDQH7L7rP1tx
	PQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=goKBrOmQ+iUzL+57+pM/oUHvJsHo30XiOP3H4D5/ews=;
	b=YXahw0zpZxhHpCbnHzABOlc0GWT9rC7Z+WPB8TmMURRC2OVKn/K+nFPeNJ5Ee4axAg
	/Y1u3wv8oVTTbpoMLuqo2YXq/NBj/PBV5+dDIf06Em7MINtUOA8rkK/+AqnVdEzI2OIj
	m2PRrDVZM5iPCgszGySfgI0GFmPxzYcU0eWcshbebmAV7qeneUJ5duyxyGTEHzW6ak5R
	ABlM4vjR3blUkcjgT+CTSee8NkrUdil7Sh72Y0j/SwgyqGcSrlTrziIHL2WlBFme/r/5
	2uq48nlbMR1/RN8N+AoLNsWEK/pJ5faRdTPlF9rKnxXCNdk3ewN6b1D2lWYSy5D+y1yC
	U5RA==
X-Gm-Message-State: ALyK8tIEz/V3GATYYNVZAXlExRRYBkm5GkYRDhYcbortRCx6x/AXpF8A61fNilKwa2DsKDhA3UWvWc0UajOYKw==
X-Received: by 10.37.97.11 with SMTP id v11mr13070433ybb.36.1468246547623;
	Mon, 11 Jul 2016 07:15:47 -0700 (PDT)
MIME-Version: 1.0
Sender: cliff.brake@gmail.com
Received: by 10.83.13.136 with HTTP; Mon, 11 Jul 2016 07:15:47 -0700 (PDT)
In-Reply-To: <1466589339.6738.2.camel@linux.intel.com>
References: <1463563901-3979-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1466589339.6738.2.camel@linux.intel.com>
From: Cliff Brake <cbrake@bec-systems.com>
Date: Mon, 11 Jul 2016 10:15:47 -0400
X-Google-Sender-Auth: D-XTLjB53YC6RZ6axSOLdCV30nU
Message-ID: <CAOd_LFxT7HGggJaTAvfH0JDkqX6CEjgGV_69zmoTBcUGekfO-A@mail.gmail.com>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git: allow using 'HEAD' as a branch name
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
X-List-Received-Date: Mon, 11 Jul 2016 14:15:49 -0000
Content-Type: text/plain; charset=UTF-8

Markus,

Sorry I missed this email -- thanks for the patch.  I'll test with my
use case and try to report back in a few days.

Thanks,
Cliff

On Wed, Jun 22, 2016 at 5:55 AM, Markus Lehtonen
<markus.lehtonen@linux.intel.com> wrote:
> Ping! I haven't seen any comments regarding this one, and, it hasn't
> been merged, either.
>   - Markus
>
>
> On Wed, 2016-05-18 at 12:31 +0300, Markus Lehtonen wrote:
>> This change makes it possible to e.g. build a currently checked out
>> revision of a local Git repository and use AUTOREV. It will be
>> possible
>> to build HEAD of remote repositories, too, of course, but this is
>> probably not that practical.
>>
>> In order to use this one must also use the nobranch parameter, i.e.
>> have
>> 'branch=HEAD;nobranch=1' in the SRC_URI, because 'HEAD' is really not
>> a
>> Git branch as such. The wording in "branch=HEAD;nobranch=1" is
>> probably a
>> bit counter-intuitive and illogical but this seems to be the only
>> easy
>> way to make this work without complicating the fetcher even further.
>> Another solution would be e.g. to introduce an alternative 'ref'
>> parameter which could be used in place of 'branch' to give any ref.
>> The
>> effect would basically be the same (with better wording) with yet a
>> bit
>> more complex fetcher code.
>>
>> [YOCTO #9351]
>>
>> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
>> ---
>>  lib/bb/fetch2/git.py | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 526668b..99d7dc1 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -344,12 +344,15 @@ class Git(FetchMethod):
>>          output = self._lsremote(ud, d, "")
>>          # Tags of the form ^{} may not work, need to fallback to
>> other form
>>          if ud.unresolvedrev[name][:5] == "refs/":
>> -            head = ud.unresolvedrev[name]
>> -            tag = ud.unresolvedrev[name]
>> +            search_list = [ud.unresolvedrev[name],
>> +                           ud.unresolvedrev[name] + "^{}"]
>> +        elif ud.unresolvedrev[name] == 'HEAD':
>> +            search_list = ['HEAD']
>>          else:
>>              head = "refs/heads/%s" % ud.unresolvedrev[name]
>>              tag = "refs/tags/%s" % ud.unresolvedrev[name]
>> -        for s in [head, tag + "^{}", tag]:
>> +            search_list = [head, tag + "^{}", tag]
>> +        for s in search_list:
>>              for l in output.split('\n'):
>>                  if s in l:
>>                      return l.split()[0]
>> --
>> 2.6.6
>>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

