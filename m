Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.60])
 by mx.groups.io with SMTP id smtpd.web11.6585.1614562162428102429
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Feb 2021 17:29:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=S9w8rlR9;
 spf=pass (domain: windriver.com, ip: 40.107.94.60, mailfrom: qi.chen@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0dE1TFUTzUJPyw9WmOhybG/B77biGdCj+V6068LU/pbbDxPHiUQDlLfoRFaCVV+WUtznwr4OnC2OpBbTjX2Q9DHOP5MJ9ZwO6mDcNDqwmpVlMefXjYc9Ltj5zAj2ayJcrMnw5L0uonm6/3fivsGY8k9xjNsGN6jcZwv8aAFKAr/E11e6eRYPK7c1+wZNBTEeufLa0qgY9WCqU/kHU3oCCjJmdDvOTZ42sM/SbQkthC0Qtl26OzEi9bl/+Xm9JfsB6mQf1enqCQuSvSLwAfHoF6Kc2vqfTEv0UmammVvSgvyTqfLUf7Tldm8xRqBixpVk6WgQ1uhSJvF5ABieaOXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW4fi7voHtRZy2dLXJ82bIlw1MAUOXjuS75tsLs47uU=;
 b=RLj+XDytqgPfpscGT5AD+JqLrH3c01EHK1mDr23iWeuBMfMRoa9DjlX0x6lLfHguCGE0StH0367ozIh7MVLiHu6SLX8R7V0hJcVeuDSmGg91j+vlIDkt7Taut6+00jlI3qrZNEGoYf/G6o4isgoiAbtrSql3UF/uo98h+L3s4ecHQ0OcN0QiGIXmyFOw0orB31M32G8uwsjid3GEws9Z3YzmWZQmAsJkhGzZ8SYCIhyHpwHzjckP1WS6j/E84iKvk5cO8haBsiyWEY8WyZRRTJaTHkGkDIlF0Fm9RF2O/JaQT2qQEtGpkEk3w/tf2eFOEl8qvac2QqaNqyAPcBKraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW4fi7voHtRZy2dLXJ82bIlw1MAUOXjuS75tsLs47uU=;
 b=S9w8rlR9NxJ4ZgsecP9x78C/BqIevxAX9LGjlNXJEWRoo2x5GCVjs8xK03YDGgBmCzpkWT1TRKecrgSYHUuzyp9F+EDdbbBpCXQOLNzse1jZKZxHbDrUUGAtFzaDfYdM5sI1iSi9PyLCtbSKmKCGyjyQLGOCc4vdergC0w0tiWo=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3480.namprd11.prod.outlook.com (2603:10b6:a03:79::27)
 by BY5PR11MB3894.namprd11.prod.outlook.com (2603:10b6:a03:18c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 1 Mar
 2021 01:29:19 +0000
Received: from BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60]) by BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 01:29:19 +0000
Subject: Re: [bitbake-devel][PATCH V2] event.py: fix regression about INVALIDCONF
To: bitbake-devel@lists.openembedded.org
References: <1666423A21FAB1A2.13558@lists.openembedded.org>
From: "Chen Qi" <Qi.Chen@windriver.com>
Message-ID: <98a516aa-38ac-8f10-30f8-ec086d07f8b2@windriver.com>
Date: Mon, 1 Mar 2021 09:39:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <1666423A21FAB1A2.13558@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To BYAPR11MB3480.namprd11.prod.outlook.com
 (2603:10b6:a03:79::27)
Return-Path: Qi.Chen@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.161] (60.247.85.82) by HK2PR0401CA0004.apcprd04.prod.outlook.com (2603:1096:202:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 01:29:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21813742-3cee-45bd-f982-08d8dc516ec4
X-MS-TrafficTypeDiagnostic: BY5PR11MB3894:
X-MS-Exchange-MinimumUrlDomainAge: openembedded.org#6614
X-Microsoft-Antispam-PRVS: 
	<BY5PR11MB3894902557EC60CEA8A9719DED9A9@BY5PR11MB3894.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Eznr/yhcG5kB1lfPTAX1yhMze4mtFtbeob7aqQwb8ire1BBQgNiMPUmmcL4NLkKxo1k/l+hov1wjnRY1Jkx17DUjF2MVlyCnG078TulmRSB5dtDcbsFGgJZWy/QIH0VYDvDFVSSw2Nnz2aUZUR3gNrKfaIxVWH2iNRzBEOs4prIIC9OckwZDRBsYq80cr1QhQHgYB4HFhxTAf6dSsz/r0ps3HGa+G6nvatC0akaEupQpz9Vu7YeS8MrC6NCMzDOv2dGFo6fF+z6etY54OBvEyRyvru4Ev12FoWR+pd0DEjvpVgoldA3sRPQA8/0OPVYR/z3Bwy41ttHU3vikA1jNT114XEWbzU9fcyNEYPCCP3AyWymEhMz9u76T4ayFM34kNOyA+8ofNr6lQUcLNSLEkNIfzWPpKcUScfEPjzUTrC5Pe74jUAQcW0KiaGG5AkuA7nS67ezqeRane8lZ6w1FuqNuG4aRY+7t4l9guLmrj1TE5EdpQQq0QAzyu0GsIfqe1ShH8Nm68UMnJaEBQx1zlWKtOMTa/qGoDygAO2GmwOKYACLzx/XPCb/YlJcEfh9wCvw+leLcUWL197ZvQyrDW979L4PIqPgAdPcXliSbqu4YAdBHKLjdBN/t1tY44NUja7qid+G5Pb4qT5LMFh1/NIr6mouXh95gmdrkZz7r/cy4w2tcIdjBzX1czOTEwq/en1pDZuIcW0DoYt3TBxmMQQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3480.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(2616005)(478600001)(966005)(5660300002)(16526019)(6916009)(6706004)(26005)(186003)(31686004)(6666004)(52116002)(66476007)(8936002)(16576012)(8676002)(956004)(2906002)(166002)(31696002)(86362001)(36756003)(53546011)(83380400001)(66556008)(66946007)(33964004)(316002)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?TFFWQXlDYW5ZRHhNUXUvSFlwUjEvZHR2c2tER20ydm1sZko4V2Urcm9ESFBO?=
 =?utf-8?B?VTcvU0FTYjh0TExrMklSditRVGJyRHlTVmJBU0xZWklVVjNIblFGV0pCb1hr?=
 =?utf-8?B?WTFnaDl4bzc2SHpPT0xHSzdIRWpHSFBMcFg2NlRhOENRUnBHajNpSDBWMXB6?=
 =?utf-8?B?eXZNSUV6UTRmSURYdko2ZDZpSjJrYjhzc1JQUHkrWEM3a3VYWmx1R0FFTGZX?=
 =?utf-8?B?dCs0SDdqRE5zekxBZnBSZEJaVzY3MlFkWGp1RnFqVEJ5MkRaZ0ZWb3UxblVx?=
 =?utf-8?B?eEFnUDkrZmN4bUVYQkVUcVZCUFBYVi9XZE42SW1GajlXL3BEMFNOeVlxdUFT?=
 =?utf-8?B?TjZLSVFzQkErYVhnTUlmZ3BrR1hid0NxYVdCQlhIVDN0azVrM1BmTzJWd3lr?=
 =?utf-8?B?V3ZKeE95VWMzTjA3VmpxczR2SmRpVnZ2UWlJU0tka0lJVDJ6TGE3TTFwc1U5?=
 =?utf-8?B?TytKeVN2d21LNnVzYUdFMFlDYUFidHJzQ3l2a3ViZW0wL1dVL2h6cVZuaVNU?=
 =?utf-8?B?ZHdzelRFMGVKQ09LTWxrSW9UV3pDRFMyMFJsS04vaVBYT0JXR01sa2xWTTU1?=
 =?utf-8?B?SW5rV2hSTS9oa3o1WkJtUzJZaUp2U3F6SW50OUg2SUJGMzVZV2R6ejNvaTM1?=
 =?utf-8?B?ak1XN1VxVFlkSjVLd1ZkRG5RUld3UWFpd3hUNm4rZHY0b3orczBubW96N2Jk?=
 =?utf-8?B?NVRIY3JhWnBZK1VMMkRTS3V0dUtheHRIWGZsUGNBeWplV21xbU4zZnRSZkwv?=
 =?utf-8?B?N3N1bzk4cE9aUDFyZlM0UGxXNEt1SWloRC95cS9GWk1wTjAyM2x1c3VYZmd3?=
 =?utf-8?B?c3AzR3dPRXRCUU5CaGljNFA5cWUvc1pyaW4zaS93MWFYSjM2cU1IUHlzZ0V4?=
 =?utf-8?B?aTFock5CR2hqbDJ0UVpZKytFTkdlKzJaQUZGMkpaaWNtaU54TVliOGNOZElX?=
 =?utf-8?B?RVdCVTRxREFWZkRpbCtqWXVPWWd1TE9xZzBON2kxNGNIYWZwY2F5WjU3Qm1S?=
 =?utf-8?B?Z0M3NnlnTWtQUFZ5dWNnVklzUDEzSXVMeEhGcW5hMlVmQ21rUmM4c1FUdzdZ?=
 =?utf-8?B?Rkd1SUhTclo1ZmtKV1dDVmxGOUhGM3NaYjhScm15VitYeWpUZTVNdG12K1o1?=
 =?utf-8?B?SWZhTkdVbzhCaDhDb3hRaEt5cTM1OWpsYzFpOUpUdmtpZWNkU0N5UE1jTnRs?=
 =?utf-8?B?d1krVGJVTThVdXhDb1FGNVh3R0JlR1RLcWRtQ09BUC9EZkxKWEoxZlpHUWx2?=
 =?utf-8?B?RmlxWnBya2VBNGFxOFRweVVNQkluWlJkTEpnNjBZMnN1bjFrWEUrdnFJUm4y?=
 =?utf-8?B?UlhxWTlad2wreEtzMkhUWkY4ekJlOHVLVFY5eERRNlV4VW5VaDQ0SHVGbUpW?=
 =?utf-8?B?OHQvdUlNUTRsSzNTNDZ2VmlrNHVKL1pldWhUZW9nTVduRzZqOXd4WkVlNElr?=
 =?utf-8?B?dUUvWXZZYnRuSHVURmtJa3NGUTBkRk9wTlNIK2JVWFBhL3p0dVZ3TzZ3QUp6?=
 =?utf-8?B?ZmtEMXhtakxXemlTOXM0TWpXY2lSQVRHMjlqejlZWFRHNjZDUTkwcUhJVVda?=
 =?utf-8?B?eUMwLzlmTTlPM0ZpOW1sYWI0ZmFhamZ2b05qR212aFJTQU5lMkp6eUNkUlJY?=
 =?utf-8?B?UHg1ZlljcHdUbTBVeE5PeWhQalhNRXltYk0rT3VtKy9SVHdIbHpuOHlWUHZr?=
 =?utf-8?B?US94SVlGWGpiR2FNUzdDNWIremtLZ0VlSEI1RlFUNnh3dXgxWHpWSHJIY1Jh?=
 =?utf-8?Q?xFHIV2oKgqKj4sG9sJRFVLZM96PORLzpwWhkw3O?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21813742-3cee-45bd-f982-08d8dc516ec4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3480.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:29:18.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8jZHrCy2w57+iRwe4SN/NU8B/+I07G+GsHRFD26m89atV/rQTfd8nNSeiua6eZQFLO7TMSWVMb6Me2XByqdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3894
Content-Type: multipart/alternative;
 boundary="------------C5635FAE316DE83A5D5AA30F"

--------------C5635FAE316DE83A5D5AA30F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

ping

On 02/23/2021 11:18 AM, Chen Qi wrote:
> A previous commit uses __BBHANDLERS_MC to record all handlers, but
> it does not take into consideration of INVALIDCONF, thus causing regression.
>
> We need to record the name before returned AlreadyRegistered, otherwise, when
> reparsing due to INVALIDCONF, bascially all handlers are not called.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   lib/bb/event.py | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 23e1f318..3e571839 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -238,6 +238,10 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
>   
>       # already registered
>       if name in _handlers:
> +        if data:
> +            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
> +            bbhands_mc.append(name)
> +            data.setVar("__BBHANDLERS_MC", bbhands_mc)
>           return AlreadyRegistered
>   
>       if handler is not None:
>
>
> 
>


--------------C5635FAE316DE83A5D5AA30F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">ping<br>
      <br>
      On 02/23/2021 11:18 AM, Chen Qi wrote:<br>
    </div>
    <blockquote cite="mid:1666423A21FAB1A2.13558@lists.openembedded.org" type="cite">
      <pre wrap="">A previous commit uses __BBHANDLERS_MC to record all handlers, but
it does not take into consideration of INVALIDCONF, thus causing regression.

We need to record the name before returned AlreadyRegistered, otherwise, when
reparsing due to INVALIDCONF, bascially all handlers are not called.

Signed-off-by: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 lib/bb/event.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 23e1f318..3e571839 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -238,6 +238,10 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
 
     # already registered
     if name in _handlers:
+        if data:
+            bbhands_mc = (data.getVar(&quot;__BBHANDLERS_MC&quot;) or [])
+            bbhands_mc.append(name)
+            data.setVar(&quot;__BBHANDLERS_MC&quot;, bbhands_mc)
         return AlreadyRegistered
 
     if handler is not None:
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">


</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------C5635FAE316DE83A5D5AA30F--
