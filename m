Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 7448A60992
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Mar 2020 14:24:52 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id h11so1131599plk.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Mar 2020 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:autocrypt:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=g3zFSleIrhwu4LSg72jA5Aez3fhHDiONK6cEz9MCDBI=;
	b=ATmm5dZ9bVKvdaTU9dWzB3F+O2us902K9cOSAaIG/xEd195qNRlPqn0fAUVn3mu+Uv
	0X+AVEndBXIbIbhkS0Y58cjj+THIlFZDCC3p6WmwXxZFAMSS4JyOQAXnfEh2TAHaJAVX
	rf+Va8MuLBqdDwwvTtI9SFkagw95J7/rTA4ILHhX/YuleKswX52E7iyRFJIaFGmIFPul
	GvJ5Cuxc6Edpjixf4vBvo4Xs5WkyjMVRXJWojEKum8o4UqjRpFPQ+QxUmfXo5GUG6QWT
	l4lC4JhC6J0GdOSrjhPbgg8aa7hM+XyxsneKalKkfH0Wh3qlhoGu5WShOB5DUtJpsxBY
	mzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=g3zFSleIrhwu4LSg72jA5Aez3fhHDiONK6cEz9MCDBI=;
	b=Viyx3XHbcebLlUtvw0wLQjyx74YIXdstocKnKhvyHrPCh0rxSPpzqZn6UvTFNDAgIw
	wmmXRP19Vu8wvBKH5YaYh6WasMYlHG4Ot4t2yFxzCiMqs25L+hVqpbarQInAPUMmzOQC
	kpgIMNXCF36i5dFExyzWBF8pLiJddN5ZyLqqkdmKg1MR1Xw/D2h1DPEkuuMTtU2zG4ry
	ouzng5hoAINKCzwEWg7maC6fwOMZOO+tEXeCENwejotDCbLguePoXkxcbTgzB7g7SOYo
	A7r00WKOwR9MpgiVt9JXok0q+AENlKw6z0h9YDcr5lpAJB+vIjAGCVgq6DOL0ef3RYxa
	E0FA==
X-Gm-Message-State: ANhLgQ2N3aVtw4il4WpdY7Fjcwu11HjHc2rAe32jiy97q1HkAxTgshoV
	rmgXSUFkhxh4xnUx3DoNHDU=
X-Google-Smtp-Source: ADFU+vuzGdKmjuzxUNV1ouesjpB6ZldkBcpCqcmquVqO6cciu2KrxzN6AJwN8C9uERJCfaKABnnyiQ==
X-Received: by 2002:a17:902:7c8e:: with SMTP id
	y14mr3492644pll.139.1584627893481; 
	Thu, 19 Mar 2020 07:24:53 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:a5c0:152a:39f6:f4c:9605?
	([2601:202:4180:a5c0:152a:39f6:f4c:9605])
	by smtp.gmail.com with ESMTPSA id
	h132sm2752232pfe.118.2020.03.19.07.24.34
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Thu, 19 Mar 2020 07:24:40 -0700 (PDT)
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, akuster808 <akuster808@gmail.com>
References: <20200215032955.3958-1-pkj@axis.com>
	<6b3a542faa054325940f888386e2495e@XBOX03.axis.com>
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <1ffcea3b-0409-9f92-2ee6-e68a20118bba@gmail.com>
Date: Thu, 19 Mar 2020 07:24:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6b3a542faa054325940f888386e2495e@XBOX03.axis.com>
Subject: Re: [master][zeus][PATCH 1/3] knotty: Make the bb.command.CommandExit event terminate bitbake
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
X-List-Received-Date: Thu, 19 Mar 2020 14:24:52 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

got them.

had to cherry pick as the patches did not apply.

- armin

On 3/16/20 4:19 AM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> bounces@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
>> Sent: den 15 februari 2020 04:30
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [master][zeus][PATCH 1/3] knotty: Make the
>> bb.command.CommandExit event terminate bitbake
>>
>> This matches the other bb.command.Command* events and without it,
>> running `bitbake --revisions-changed` will hang indefinitely if there
>> are changed revisions.
>>
>> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
>> ---
>>  bitbake/lib/bb/ui/knotty.py | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
>> index a0340dfc20..cbb289b05f 100644
>> --- a/bitbake/lib/bb/ui/knotty.py
>> +++ b/bitbake/lib/bb/ui/knotty.py
>> @@ -590,6 +590,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>>              if isinstance(event, bb.command.CommandExit):
>>                  if not return_value:
>>                      return_value = event.exitcode
>> +                main.shutdown = 2
>>                  continue
>>              if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
>>                  main.shutdown = 2
>> --
>> 2.21.1
> Please backport the three patches in this set to Zeus now that they have 
> been integrated to master.
>
> //Peter
>


