Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id CEB48606D0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 17:38:06 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id l68so40930249wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=QvWYGq1gzKZkSHiJ2FwYklHif9eDnicVv+iGxX9TpxE=;
	b=nirLiMJKoAf02slk1Qnm74GBemr0AtutFKoERH5obv4SJgINYf4buBFQVgGjHcmRV9
	n4jV6H2TgI9T+9MG9pu04Iffd+zStJZ4rl8EUXUtU9vMAC2n8hFdaxCEHQoTeUWemEGn
	SHu+sCPnC1QA0jZ4lS0AgSyJspYytwNivf320MWrOTGK5HpGbJbS8/OFRwukyKl24Oh7
	YsdgKg+ZgSO5owqkiomtG/4edniUYhXKGHuNUqaTgA/5ngSdgoevCVBPrOcMNo0mcVmQ
	xj98oou6kdMelV/76mC1VjeVL8s28DLjrQgSMPLi6m14Fa52yEw7aQaN9wcMmENshLya
	i6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=QvWYGq1gzKZkSHiJ2FwYklHif9eDnicVv+iGxX9TpxE=;
	b=Dycyhuiq0EDDNTD8svPlQ5kTEPP2HACTCcOARx7QUsqKdzvpywT4ZpRc+81Z9QCghG
	FOgT1AHx9naOPMDFhUD66u4m7lp0E61BhPrjwFiVSrNnFy/iqiBX60h+7Vh0DadXNYK7
	js+uiCdl9vrNXRbjyeXlziTWJpjlcXMvJQu0KffwLPIC/AK584zbfFJp7jXX38rJhX12
	5JxeQJ8bbwcB543luNPU4UiVKftfy0wE25foVfcCxL2yOrPnbn02ajShSMTFjQkI7JO/
	hhQLX1n57PwOnF3rPfOV7bbs6QExCBTK6CYFws6ZEq8YStRdWl2zXej6LX6SqHZvt81k
	p3ag==
X-Gm-Message-State: AD7BkJKyWAep94wXAPvuk8VynVVQsR+e9myME3wtAjIp8GfIxTSPMbvGuQ1OyHJsIVHSseyhtR12PnD+9bVjmw==
MIME-Version: 1.0
X-Received: by 10.194.63.242 with SMTP id j18mr5923663wjs.114.1457631486631;
	Thu, 10 Mar 2016 09:38:06 -0800 (PST)
Received: by 10.194.201.104 with HTTP; Thu, 10 Mar 2016 09:38:06 -0800 (PST)
In-Reply-To: <20160310170350.GL2573@jama>
References: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
	<20160310170350.GL2573@jama>
Date: Thu, 10 Mar 2016 09:38:06 -0800
Message-ID: <CAJ86T=WeQg_r6jNk2KK5En09mFQX3m0aNtwwtxUyzGpzRFqZGQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 17:38:07 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 10, 2016 at 9:03 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
> On Thu, Mar 10, 2016 at 08:15:32AM -0800, Andre McCurdy wrote:
>> Referencing PN only is ambiguous if multiple versions of a recipe are
>> present.
>
> Would it work with FILE to get immediate pointer to file where to update
> them?

Yes, that works. It's a bit more verbose but having the full path to
the recipe is useful.

>>
>> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
>> ---
>>  lib/bb/fetch2/__init__.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index f86014c..124420d 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -1102,9 +1102,9 @@ def get_checksum_file_list(d):
>>                  if f.startswith(dl_dir):
>>                      # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
>>                      if os.path.exists(f):
>> -                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
>> +                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('P', True), os.path.basename(f)))
>>                      else:
>> -                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
>> +                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('P', True), os.path.basename(f)))
>>                  filelist.append(f + ":" + str(os.path.exists(f)))
>>
>>      return " ".join(filelist)
>> --
>> 1.9.1
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
> --
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

