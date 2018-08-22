Return-Path: <Rasmus.Villemoes@prevas.se>
X-Greylist: delayed 40988 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 23 Aug 2018 01:12:06 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0108.outbound.protection.outlook.com [104.47.2.108])
	by mail.openembedded.org (Postfix) with ESMTP id 597107944C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Aug 2018 01:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bqk/DbwXfjl+Ttts5lNmcMs/8wP+3Kjaj3v39h8uQAc=;
	b=RTBlDtfDeiKsXKVCSBoR+BHlMXCaw2vBPcC2RZ7Twr6CjUr/ZY5I8RuJHpSDEoWFf8x4upmJl/k6vEiq7QhICs/Tq+zajibD9+0xMADcUdwmS9wgfWxVseb55B56qDYWSo6OpRaM/9biGdXLkJqroNl0hUov/08NkIn1UHeH14Y=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [172.16.11.40] (81.216.59.226) by
	VI1PR1001MB1344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e5::13) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23;
	Wed, 22 Aug 2018 13:33:52 +0000
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20180821140416.10764-1-JPEWhacker@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <c18b7f96-8809-0224-b419-2fff12994680@prevas.dk>
Date: Wed, 22 Aug 2018 15:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821140416.10764-1-JPEWhacker@gmail.com>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: CWLP265CA0029.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:11::17) To VI1PR1001MB1344.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:800:e5::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 711d325b-9e96-4f22-d279-08d60833e6bf
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR1001MB1344; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1344;
	3:2/uKzRKARlxBBYxt9vGbX/7OuzWFnN1TDjUSgXPuthraE72ldMHg0LpYm+QBIP4UDahECq7+Ap1nY45P5vkZ/ABqjHGczXToNMfV6k1O3c+/+cdvHJJbYHzikJn0m9+GoELMezf05fSqKWyemKzZo3ILP3MnLG9pE7gdpI+Ok9mXwrIpO3RBQhb7xSr86o5xlf0FkJeEk5gZuCnYBfbiCMdafPU+L8aHsgRaRtBA2eDXrLFUL4n4ARy+12pnDDhF;
	25:enRct1+jrziEzlpxL8zGe+BNKaKT6t57Yv+9uXRA4djtAJTXhbTV+Qwg7zFgWPhWQSH84u7ZYd/OgDOBX1erSmlAgmEgz2KWkN/vTnZTNz+FEtZGvq0yC0FYnJJSqcQh5PwEfbktpl0yRNKfnsMC25JnOk+45uqTIexrKhR3UqYhzpVzKZYU53HmcmWduSni7imwh4p6Og7cUIqF0AT8n6CF6vaxeBoL3oFVB6+BtU/Yt/iXlDfblq77IDfdFHwsVFv+4II0HIU+aqmwCqk3VjqzEKTCe6ymmAnYWKRnIPrBsnRrEDsVaynmyW5a0v6jsuiBUdkbrROZRcETe+/mxw==;
	31:3H/O+eqNYtoGgXTvMIsafrqKYjE4+I8WD0mG03l/0ni4f7HCgvMfoXD3ejadEWYUjbeOI3m9HVZ3BNSawlofhaKE4XgCu4CW4wRZSMzJsm11V3yYSQuJUIhQBibloSkjovh2XJhOQYY70j05KxlZhEiU8r9Q+lB4Qfh9rRhAXWDwYn89WZMQQTOso9i0X1X6ir+vkYDnWojWLPuLmNUyZZNsrKfLJRluPiQZFxIuKRI=
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1344:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB13445E475119599EB30D8B9C8A300@VI1PR1001MB1344.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);
	SRVR:VI1PR1001MB1344; BCL:0; PCL:0; RULEID:;
	SRVR:VI1PR1001MB1344; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1344;
	4:uB4+17iTsq4xuktY0f8JIrJr+gV/vk8smjz/lx3mZ1gkAufxyiRXm+meXDTlhKS1X80VO6Mpgg+Ak5df7r1a2eioBNUcOP3+gX5kVDZWXNRDT3JmJt6YyafrzksYzAfzT+HyXLpsCoAG/xjMBO0JwbuTv4kfynAEasT4/1HAFlVHtfWU/iz8QZt5PxfW11/9vo63Zc2W9LLvZGyfdDJlRsEtLFEKVa9309ZXffSWYWeNKIMYRnxbbxP3ObE0h6gYJZko3yndUfyRBoeSW+b7cABTC19wJtobeMROlxCGgpN8uJ7KR8a3eanPm379UXWF
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(6049001)(366004)(396003)(376002)(346002)(39850400004)(136003)(199004)(189003)(6246003)(446003)(6486002)(6666003)(25786009)(39060400002)(316002)(16576012)(5660300001)(65826007)(74482002)(476003)(16526019)(97736004)(58126008)(186003)(575784001)(36756003)(72206003)(11346002)(77096007)(486006)(31696002)(42882007)(26005)(229853002)(956004)(66066001)(50466002)(31686004)(44832011)(106356001)(386003)(105586002)(14444005)(2616005)(478600001)(53546011)(65956001)(65806001)(47776003)(8936002)(8676002)(230700001)(23676004)(76176011)(81156014)(6116002)(81166006)(7736002)(2906002)(52146003)(2486003)(68736007)(64126003)(53936002)(305945005)(3846002)(15974865002)(52116002)(8976002)(18886075002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR1001MB1344; H:[172.16.11.40];
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjEwMDFNQjEzNDQ7MjM6ZWVNc2ExMU53MitGV2pIVHkyb0ZqaTds?=
	=?utf-8?B?Q3Y5SzYvdUFmbXA2VFNWaitXSkVnZlRGSm9TUGNPeHRVMkNaanFRZTFrclh1?=
	=?utf-8?B?Q3VCWUJvcHRTSTQ3cU4xUzA4K1ZjaDV1aGxBb1BNTk9mU0t5eGZOMEFxTHVi?=
	=?utf-8?B?ckMrTWYxNStjNlNLRGVkVXFGb2Q1RzVZeHhVQUdGMUwxSEhaRHJaMUdRYU5o?=
	=?utf-8?B?VXBIZ2ZKYVp2VGc3VVBlODR5K0xGYWhZbzFiMERWR1B6d3BHM3VCN1YrdWtx?=
	=?utf-8?B?eldQR0lqVXNadlRNckd2Y00zMkZmQkNpby95ZU9jVkdYMUIyQXNPZ0NpOVhk?=
	=?utf-8?B?YiswUVc5dHpiVnR4VERwdC96NDRRdytBY1ExaGdMUytnbUdHZUhoT2RmS09N?=
	=?utf-8?B?ZlAzN3BtU29xcWwyeUtPd0VNMUxIaEJmdlhYWWJpUTZTMGhtOXV0NXN5aDZM?=
	=?utf-8?B?c1FWSTMzSlI3YVNFQ2tvdGpORUdlNUE4UUVWeTBaYndCdzlsTGVDUkpKaVJ2?=
	=?utf-8?B?ck8vaStLMXpadCtNWW5wNUdBSXRET1plK3l5cUlBelNvYjkzKzExZHZyK2NK?=
	=?utf-8?B?Z3lTZVppUStkelhlMW43T0pGYlRMUFVSSWhKb2pSN2creHBhdU9RN295ZUUy?=
	=?utf-8?B?QlZmaXdQc29lTmVGKzdBOVAydXViTjBDSVhoWkhQL0l3dkxhQmdwTEdjQTNP?=
	=?utf-8?B?RDNHTFV1aGVHdTJQMGlmME0vaVJuSWExTEdUMjFmVHY4ZHFwcXBnME5Ndmdy?=
	=?utf-8?B?REFQc0JVR0k3UVFKSVMvNG9ESmFwOFJsK3YwNzZidHJHeXZXOEl6S1AxYnpz?=
	=?utf-8?B?NEtEL085M21CUXNvKzI5Zi9YWFcvKzBFQXcyU0owSzJHV2JiSXJlaDkvQTJo?=
	=?utf-8?B?NE1QbXd3anhFdHNsRUtQWWdVN3M1dVBqL2xIWTVNN29ESm1nbE5wL3QzZXVL?=
	=?utf-8?B?WG9laDBaakxUakk0TUFGbmQwRG0vd3JPbFM3dGw3bmYrN0NxOVlNaWlmZHdY?=
	=?utf-8?B?N293dldubmRpdVFtVDIxV25PNnJ5QmdDampvTGEvOE9WdklTQzBaWUxZOWxR?=
	=?utf-8?B?aE82a0xtcDM4VU9pSXl4V1NVQUFTUjFKQmYyMjJ2RS8zV3pjN2tHUlZJVDdu?=
	=?utf-8?B?TVdqWmhGQjl4WGJRUzZWZjVxbDE0bGxzcU5TRWIrZnVvdGdjU0puUU5keW9L?=
	=?utf-8?B?S1BxeUdwZ1VwMHZidFZlRSt5aldONkVDN2NxL3BwcERKdExIWFBuY3ErUUlQ?=
	=?utf-8?B?aGZvVG8vSzhZR2pEMktSd3R3RUtCb3RabW43dTI5Nk1DQmwvempnWExBT1BR?=
	=?utf-8?B?b1oxTzJKSmtsYmUvNkczeU52WmE5bUh5WXpqRXBJOVh4bDY2WFpGUjdjYUJm?=
	=?utf-8?B?TElBYk9GVEE3MFh4eW5wTjNHZ3dJbmxmdURkL0xURCtaQVRDajFxUTNUR3hs?=
	=?utf-8?B?cC8wVTRJL21yQW92WVlUMGpSL0RuNjRBaW5lcXN4eUxldFV3M1V5ZXNtMVdD?=
	=?utf-8?B?U3dob1dvQTVwUlNxNVYwQ0xRaG9zYkU2bVd5WmRZRUxFdWpDRWhTRXlDdlZr?=
	=?utf-8?B?NWJJemlVcTRyTGtkdlUvaTJ0M0JYTHFXVTFmMU4zTkExT0Y5bWhvUjZCRDVW?=
	=?utf-8?B?Mkg4MmFsV0llTWtmZks3MU5HYWdYU1FCcy9EYndHRWUvZEdsK2pqTVBrQk8w?=
	=?utf-8?B?VS9lYVFON2lSRUZ6OFF3MkhkZ0d4bFEwdlQ4VVFlWEIzaDlLbTkyZXExanRS?=
	=?utf-8?B?b1NNTzltSXBHcG1EdElUeTA4ZVRMSTNaYkpkbDlFVitYdnA1Y2JlMGV0OHoz?=
	=?utf-8?B?MWFCVk52Y2FoeWpya1dwWEtmTlp6dWRZYXo5MFh2T2pwSUFwK0lsaVZDZEtB?=
	=?utf-8?B?YkkrdGJxelh5MTI5STVMRytNWkNoY3Jydkg2Z1hZUUpuZ0VOaUhIbFIzRnVU?=
	=?utf-8?B?ZTQvNUNHL2VWSEJFaGh4Q3B0WXRCbTF5UWZvN2VTTmpvcEx1aFBQRUlCZEdI?=
	=?utf-8?B?V1JROVVBZUZ6d0FxMnkvVlNzWmtzVC8zVWxxWDgxTCtZNi9MMktpQUVEc1V5?=
	=?utf-8?B?a3hRV3ZtTGhGenV5QUJrQURPZE9wbkF3cVBnc3NBYkJDUmpOWW5menRKR3R0?=
	=?utf-8?Q?Crnz6gCIFD3AGh3+JArZ801C8=3D?=
X-Microsoft-Antispam-Message-Info: R8GWt8VN8AhJ/jlMmODnX881eVQVv23pswXSyyoKhugXKMU3XnR9PaGMsTSJaLdWdISMOnE3plOLR16krPiyB2Yp3EDjOAfGaKDTaDZFoseVaDNcy+Y+zz4PHRsF22klw4oEZPPxlopmKBNcyg7Mc++W0dfpHgekLpEy+GaS6C6n83DkerrKHWDC3IT2hCisEMxCXwPSmS49RbJ4R3TT++rAlpBENUoIPr/NJt/U6L7wrWD1ZT4mxQhjblPanQal7L1bQjpro9w6TWWR8O2f7IfJlt4pjA14mI1eEnPpOvNAolD454ZwzexsJWm0YCLKkkcRfk6lrMI/8eiH7UeTe3lj14gzTRIkOre23cEffjo=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1344;
	6:S235vp1Ku08udu4ifv8xhXTd11GQN8ibiEiDSPMZB22OwOswMTAa9SRedUsECuFhoN5PjQ7PUbWgwudOxwy/mZIz5KDrAxxNcehe9a7VDF+6kRVIzlp8wj8Bpm6Q1dpABUg+4gIdN5JAzg7scPT8McD9gaaV1sE4KIpDA+KfERCBxVPhlmCNyZCRIaatXFrbRvpCbhQTxJVuYlj48fmRHI+QQKppMWI+UREb2DMUmiqinI/dvl7NLFRhNwTPUQ7XogFNX0QPoyYPiuLexIKv2TyesvYtQtC9CYjhJOJ6khpq4WLXFYDQdkZ4GmklJieHeke3pKi0ImpP0UdeF6pJL1hh1MN9p27vnvg/pDWKXpk1Fcm0rPbBJoaVW4U02HE8U/0n9fTClx3bEd+aoPAcHtZOUvB6uSPoGThgLHDCLR4OcxKcb6abtFvXeavMnxvMMFDSgggfWS4LUQmIML9jRw==;
	5:VHXbproahXrfILAh/rXtr+ZI+SaaHYrMhUPo4EbhHAPQsLuFJeKRRcWBXPlEhieRXyvZGLMkWUJZsoMPYjXHe8RIWjnKRZIZI978a16qNl88eyaKLwqN+6rxsC7uFNxihNKJygIHvzLIGspHuyzeZDpKTtTAYrhJGYMLyj/Kk2k=;
	7:FVnpaQHBrLzImo3VTYuIH5r63BYoALEt1F7afChHBH6aHE/YijxPyvnFt0XQNuH1+X6oJjga9gEgvnXguLIIjS/5JtKSj/xAU78rQ+qJ/oIeSxdZX/nwZflcolL7I2MjX9M0FaQHN33XqADXYIY9zXrRFhB3F709Kd7hLYymPJdY8+B7w24h2lfNksRw3TKAu/rWhprfaq5/fKylgpXbGYZ9qQLO5kNznruqWzm+mpUhQYIv49eEeDu/EMXh87AW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:33:52.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d325b-9e96-4f22-d279-08d60833e6bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1344
Subject: Re: [PATCH] daemonize: Flush stdio on exit
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
X-List-Received-Date: Thu, 23 Aug 2018 01:12:08 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-08-21 16:04, Joshua Watt wrote:
> In spite of a comment suggesting otherwise, os._exit() does not flush
> buffered output from file descriptors before exiting the process like
> os.exit() does. This means that any un-flushed output is lost in the
> daemon process, in particular the traceback from any thrown exceptions,
> making debugging exceptions in the daemon quite difficult.
> 
> The solution is to flush stdout and stderr before exiting.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/daemonize.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/daemonize.py b/bitbake/lib/bb/daemonize.py
> index 8300d1d0f0f..bf16793468e 100644
> --- a/bitbake/lib/bb/daemonize.py
> +++ b/bitbake/lib/bb/daemonize.py
> @@ -49,8 +49,8 @@ def createDaemon(function, logfile):
>              # exit() or _exit()?
>              # _exit is like exit(), but it doesn't call any functions registered
>              # with atexit (and on_exit) or any registered signal handlers.  It also
> -            # closes any open file descriptors.  Using exit() may cause all stdio
> -            # streams to be flushed twice and any temporary files may be unexpectedly
> +            # closes any open file descriptors, but doesn't flush any buffered output.
> +            # Using exit() may cause all any temporary files to be unexpectedly
>              # removed.  It's therefore recommended that child branches of a fork()
>              # and the parent branch(es) of a daemon use _exit().
>              os._exit(0)
> @@ -79,4 +79,9 @@ def createDaemon(function, logfile):
>          traceback.print_exc()
>      finally:
>          bb.event.print_ui_queue()
> +        # os._exit() doesn't flush open files like os.exit() does. Manually flush
> +        # stdout and stderr so that any logging output will be seen, particularly
> +        # exception tracebacks.
> +        sys.stdout.flush()
> +        sys.stderr.flush()
>          os._exit(0)
> 

Well, that's of course better than not getting the output, but there's
then the issue of double printing: The intermediate child does _exit(),
but the grandparent may have had stuff in the stdio buffers before the
very first fork(), and that content would be inherited down to the
grandchild. So I think you should (also) explicitly flush stdout and
stderr before the first fork().


-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 3
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk

