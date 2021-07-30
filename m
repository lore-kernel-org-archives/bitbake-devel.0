Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.49])
 by mx.groups.io with SMTP id smtpd.web08.24677.1627654090532350687
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=At9YJw0N;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.49, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9zCqwDuwD/rhUFBt/qhWfuI0yPp02LhR09POvRbXH1Dnnc5Y33AFEeR5VizLweuryWt4NuWLkzycsWaQuBgd3meMPvc/2uV6YNccDaVzl/n4wAZkakoSkag9cuoiJw2dI0WF3/yaLNYhmun1aqlnCsYSI+s0+46Hi/jPCdQC8Cs+jZ6Uo3IUKGdhPhJP6Rg2KKesF6RNUJx9KZw/aI7nAZ+W270M2FmfiNROLcOlh9IVVx31BzLN84RVmi0QsfmSkIZyiJVCQwoDgE/1nrwrRzPfduUu7JguKqRL2I0yQYPIPOO7w/XK0F8z4XBNre+IXvhGMphlscYMsTnmcx3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGcdPUROo+qtGgrHNN9N6yyRD7mxQBtcvfYjLCL/eIM=;
 b=iK5YGo/mtfZLgkcwa61UFjOTBNXmRulN7MI3gsd0+II7uzeTNlbq7KmNlwJ2yGbY8SXKxPZ5ea97l7johu8TJD3H9/YcCJkP+tX6e/AatSjYf0oRunynLKfjSbvqKPsEKULKgqrDXmEaIuC/nvJcEEqhK1xg/VweiIfXVUdSVoGQUuPua31ed7BEGqF3qVXuVOYpFIkXMhEqczdGPILlTjTe1che37rDFVxDEUQHBtHAlUOu1mFjlcXBEU4tHksayQflS1H4VmaVzE2j7cUJ62PzoeWFIc3Jmb7y2Ye8VaRxuk5hor6GIdnM3t6zque5i6sJnYcIgVvees22C6sFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGcdPUROo+qtGgrHNN9N6yyRD7mxQBtcvfYjLCL/eIM=;
 b=At9YJw0Nx58aOgQ7mUzJqFtI3a22a1fC62O2j6Ljmb5kqvD3MFRJgRV9JDqEIRoEMdSeOnS4rZ2kWJiL5hFzZBb//Bl41yaJ5vhXiuVBmdl/sfqnIJQW8KgQgs/m98M5DBB6fATbSoM1EjexGzRyPljxE8FXKUvCJWgL+JsRHZo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB6691.eurprd04.prod.outlook.com
 (2603:10a6:208:17a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 30 Jul
 2021 14:08:06 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 14:08:06 +0000
Date: Fri, 30 Jul 2021 16:08:04 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/4] doc/lib: Update to use new override syntax containing colons
Message-ID: <20210730140804.fsmnmhdxvbdbtcdb@fedora>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
 <20210730134706.3360651-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210730134706.3360651-2-richard.purdie@linuxfoundation.org>
X-ClientProxiedBy: AM0PR06CA0117.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::22) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by AM0PR06CA0117.eurprd06.prod.outlook.com (2603:10a6:208:ab::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 14:08:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d4d771-461b-4e89-5066-08d9536373f8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6691:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB6691AEDD7C5C85ADE86F3824C2EC9@AM0PR04MB6691.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HYzxCqtPqyj+WwU7MxaEYbwrgJy6U0v3Hu6f8DweJQ0zNFkgIOcchhXMCCB8uuK6dx97yuUghE05l50z8FYI7iFq9Q4z5sfP/jYIwVq7xYjTTcqm6T98TxFSnpDuCwvitNrtAq2/n+wADdU/1IrlA60F6eFkJiHEy9B8T6BtWYhlilCh3wNOrcM9p2kS3+IHaH8OqItvwzORR+7wr/49aWEKDz6/a90cZmyzkI/MWxx/ukaFYFm1qntoasOjun4LvKzgSYsgv9QDsVpLsP63WyyNGu9KUaZTBav6p+qSFn0h+YEWZovM8fRdcsVNs74bQUOEUoqBjyi+yPLPYSgN7IwNogitK8AX3n7IVP2yXzuJ7L2XZoob6UrnIJClgoZ66R0xystH0/hp5CH2py7O9SLzo47DSUAURhLPH6E3kPu9EmiFOFjHwdaHkDyYmQoKHOHVyJ0LOy9W43ZuPOjfFT5l4c/SLwFme6XBk6clNr4Ab4CoEbFb6e1JaIvXrR1Ym8dAsZCl7GCW9fojKCXNqabLytwYh/VaqbHWgBL81PAPW+7a4RNsAMiFkfRUwyFFnyXLDtV1ACRf5ai6ewXhJg4ozdb4FV/7k2KL0svPcG6OIdGwf/hW8zyB7vy7GaUFvyAfbmO7iT/NEYrDUUCPIj9bRQKIjjOVPpsdjWtgTKWnp/DMPfPm7KgYs9wES2VTJROyy4goM0XnTFSNet9vfIEbbbGcYNRwHQ7W/6gLD3kw+87Pa50Hak4pAytCxb64CZPdSXnxiL2nUKtAfnoqoA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(346002)(396003)(376002)(136003)(4326008)(9686003)(44832011)(8676002)(956004)(66476007)(66556008)(33716001)(52116002)(6496006)(66946007)(8936002)(83380400001)(86362001)(316002)(38350700002)(38100700002)(2906002)(478600001)(9576002)(26005)(3716004)(30864003)(186003)(6916009)(55016002)(5660300002)(1076003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?px2Xm/BRV/YNEBrfiCkB1vkLVbMq8t6iq6iJ7uWkxx7dCL63JMEzc0McGuOU?=
 =?us-ascii?Q?L/LxyvPyEVaCtEy/Ko6KT5zc8FDaCuq2n1a6CazJUAJop3lWzjzuF/mwZJs4?=
 =?us-ascii?Q?TMf9sMqTkml74OpytqlDAazfE2eGjQ7eOaurb91vFT3lffb/yuDHOZwRFhDo?=
 =?us-ascii?Q?7kxkBERZcNeEIJc5yD/gAxu83IYyB+w66qTjJx8xgLFg32ZFcQXWOPlZOezK?=
 =?us-ascii?Q?/JKEhXSIx79W5OXhgKLXorsYt+QkCFyvbkt5hjgjsknwJsJ/IWg8vRBxkLM4?=
 =?us-ascii?Q?53AvC1qh9kraeLScZXJsy6VXBJAtkbFNXdy/zHn3xu3ex+Fywhtx+C6JY30K?=
 =?us-ascii?Q?a5qKr+KgfpcA/x/KIKXW9i7VYY1sF5pR7KU4Y/eGJRMUlIHrpNcDZhPNi1k4?=
 =?us-ascii?Q?jpExrR5+Ir1RuYffSwXNgLOL7oLtiOy0t3gPZrm8IKJoxf9Zu735kA03Nw02?=
 =?us-ascii?Q?DN++IQrcj+18v+Wc7GSa41BodgkrN1CQMoCYQqH2uky/vBod8oCqmB3APB8c?=
 =?us-ascii?Q?MNFJjY0oGL5tfxtISTufWq1mxcodtRzfQrLMjrWZV6V5hiDG7WybVWj4wMe7?=
 =?us-ascii?Q?nhGh2U3M7iS+HLaZHC8GmndYdlRAFayXDscf+bYJiv9Rm/UF4UgwTmiBel6m?=
 =?us-ascii?Q?7hECcC4JjNQp1uHlB2DNKJFC71Mq8tnn10f5zTCfqVeH6lQ9/MmsApVgnOZP?=
 =?us-ascii?Q?KRs6LaKYEKjo+oNCmif8K+ajxpE1kEQkfI6pAU8B2nru4anWc8baXd1d38Z+?=
 =?us-ascii?Q?NDqDZHbBg9UDUVZhaGJtX6KtvLjJcxnxpkytOUuSSdvhoZyYTn0QIUi2ZrMR?=
 =?us-ascii?Q?EpIKmhwZLTuyMzcvkxTz6oyTBjoGHV5ZE84EC7fC5CSiRyaghFRt7zD+0we4?=
 =?us-ascii?Q?KWk9aoTVjcfjO49xwm18JYiPQisxsfnUIWS7zo6DytY76JBDkni3xzb0T1DH?=
 =?us-ascii?Q?T32+/kl51Op6oM+8oQvqyrFjHxkYPWOWuN6v1ePJYyZSq/8jYI+lYsqv65SP?=
 =?us-ascii?Q?QQ/yZEOFe6UuEKdRKMjrN1htpYKV62L16zDiNDhOVgPR42Uv9B3P0vxlyJ1k?=
 =?us-ascii?Q?CVYtwrGAa7nLo1eXKvagQSYXKZn/Al20yJVPAnC6KWZwaGeedd6sjRZzJI0h?=
 =?us-ascii?Q?J3m5PgYyn+gxUI57i9eIeS98DJcqCt8lrRLe1Ogb9EvfUWBr4NG6vp7FM5u2?=
 =?us-ascii?Q?zlnI44GAn0EclzWoJy5bkB3HrCHu6X61xH8NNhyv4Eyb+74Pfx3ZQhdu9upP?=
 =?us-ascii?Q?Z/WMh/s34ySJCHQqkjMoGepgcn2/VzP4Q5ffS2hnRF8hAcxFhn5cMDmADTk7?=
 =?us-ascii?Q?2z7cE4+J7fFloJgB8qyYNRrn?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d4d771-461b-4e89-5066-08d9536373f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:08:06.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETEChGg+cNxJOwROb5XvMNUlfIMK7nrROGGCYarGeOnTRJINBYvHCguI6MydeTQGchKSFzNcGsY951UjLiXEcQzAD/WBOaplrlXwq38c/0rYWpkv6WR5tjkGTcO5vOZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6691
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,

On Fri, Jul 30, 2021 at 02:47:04PM +0100, Richard Purdie wrote:
> This runs the overrides conversion script in OE-Core over the bitbake code
> base including the docs. A handful of things were excluded in toaster
> and for the Changelog file.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  contrib/vim/plugin/newbbappend.vim            |  2 +-
>  .../bitbake-user-manual-metadata.rst          | 64 +++++++++----------
>  .../bitbake-user-manual-ref-variables.rst     | 14 ++--
>  lib/bb/fetch2/__init__.py                     |  2 +-
>  lib/bb/tests/data.py                          | 52 +++++++--------
>  lib/bb/tests/parse.py                         | 16 ++---
>  lib/toaster/orm/models.py                     |  2 +-
>  lib/toaster/toastergui/views.py               |  6 +-
>  .../management/commands/buildimport.py        |  2 +-
>  9 files changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/contrib/vim/plugin/newbbappend.vim b/contrib/vim/plugin/newbbappend.vim
> index e04174cf62..3f65f79cdc 100644
> --- a/contrib/vim/plugin/newbbappend.vim
> +++ b/contrib/vim/plugin/newbbappend.vim
> @@ -20,7 +20,7 @@ fun! NewBBAppendTemplate()
>      set nopaste
>  
>      " New bbappend template
> -    0 put ='FILESEXTRAPATHS_prepend := \"${THISDIR}/${PN}:\"'
> +    0 put ='FILESEXTRAPATHS:prepend := \"${THISDIR}/${PN}:\"'
>      2
>  
>      if paste == 1
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 3e14163ebe..db44e26fbd 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -281,11 +281,11 @@ operators in that their effects are applied at variable expansion time
>  rather than being immediately applied. Here are some examples::
>  
>     B = "bval"
> -   B_append = " additional data"
> +   B:append = " additional data"
>     C = "cval"
> -   C_prepend = "additional data "
> +   C:prepend = "additional data "
>     D = "dval"
> -   D_append = "additional data"
> +   D:append = "additional data"
>  
>  The variable :term:`B`
>  becomes "bval additional data" and ``C`` becomes "additional data cval".
> @@ -312,10 +312,10 @@ When you use this syntax, BitBake expects one or more strings.
>  Surrounding spaces and spacing are preserved. Here is an example::
>  
>     FOO = "123 456 789 123456 123 456 123 456"
> -   FOO_remove = "123"
> -   FOO_remove = "456"
> +   FOO:remove = "123"
> +   FOO:remove = "456"
>     FOO2 = " abc def ghi abcdef abc def abc def def"
> -   FOO2_remove = "\
> +   FOO2:remove = "\
>         def \
>         abc \
>         ghi \
> @@ -349,15 +349,15 @@ If, on the other hand, ``foo.bbclass``
>  uses the "_append" operator, then the final value of ``FOO`` will be
>  "initial val", as intended::
>  
> -   FOO_append = " val"
> +   FOO:append = " val"
>  
>  .. note::
>  
>     It is never necessary to use "+=" together with "_append". The following
>     sequence of assignments appends "barbaz" to FOO::
>  
> -       FOO_append = "bar"
> -       FOO_append = "baz"
> +       FOO:append = "bar"
> +       FOO:append = "baz"
>  
>  
>     The only effect of changing the second assignment in the previous
> @@ -538,12 +538,12 @@ variable.
>     that value based on the architecture of the build::
>  
>        KBRANCH = "standard/base"
> -      KBRANCH_qemuarm = "standard/arm-versatile-926ejs"
> -      KBRANCH_qemumips = "standard/mti-malta32"
> -      KBRANCH_qemuppc = "standard/qemuppc"
> -      KBRANCH_qemux86 = "standard/common-pc/base"
> -      KBRANCH_qemux86-64 = "standard/common-pc-64/base"
> -      KBRANCH_qemumips64 = "standard/mti-malta64"
> +      KBRANCH:qemuarm = "standard/arm-versatile-926ejs"
> +      KBRANCH:qemumips = "standard/mti-malta32"
> +      KBRANCH:qemuppc = "standard/qemuppc"
> +      KBRANCH:qemux86 = "standard/common-pc/base"
> +      KBRANCH:qemux86-64 = "standard/common-pc-64/base"
> +      KBRANCH:qemumips64 = "standard/mti-malta64"
>  
>  -  *Appending and Prepending:* BitBake also supports append and prepend
>     operations to variable values based on whether a specific item is
> @@ -551,7 +551,7 @@ variable.
>  
>        DEPENDS = "glibc ncurses"
>        OVERRIDES = "machine:local"
> -      DEPENDS_append_machine = "libmad"
> +      DEPENDS:append_machine = "libmad"
>  

s/DEPENDS:append_machine/DEPENDS:append:machine/

>     In this example, :term:`DEPENDS` becomes "glibc ncurses libmad".
>  
> @@ -559,15 +559,15 @@ variable.
>     example, the following lines will conditionally append to the
>     ``KERNEL_FEATURES`` variable based on the architecture::
>  
> -      KERNEL_FEATURES_append = " ${KERNEL_EXTRA_FEATURES}"
> -      KERNEL_FEATURES_append_qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
> -      KERNEL_FEATURES_append_qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
> +      KERNEL_FEATURES:append = " ${KERNEL_EXTRA_FEATURES}"
> +      KERNEL_FEATURES:append:qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
> +      KERNEL_FEATURES:append:qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
>  
>  -  *Setting a Variable for a Single Task:* BitBake supports setting a
>     variable just for the duration of a single task. Here is an example::
>  
>        FOO_task-configure = "val 1"
> -      FOO_task-compile = "val 2"
> +      FOO:task-compile = "val 2"
>  
>     In the
>     previous example, ``FOO`` has the value "val 1" while the
> @@ -582,7 +582,7 @@ variable.
>     You can also use this syntax with other combinations (e.g.
>     "``_prepend``") as shown in the following example::
>  
> -      EXTRA_OEMAKE_prepend_task-compile = "${PARALLEL_MAKE} "
> +      EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
>  
>  Key Expansion
>  -------------
> @@ -618,7 +618,7 @@ example::
>  
>     OVERRIDES = "foo"
>     A = "Z"
> -   A_foo_append = "X"
> +   A_foo:append = "X"
>  

s/A_foo:append/A:foo:append/

>  For this case,
>  ``A`` is unconditionally set to "Z" and "X" is unconditionally and
> @@ -635,7 +635,7 @@ This next example changes the order of the override and the append::
>  
>     OVERRIDES = "foo"
>     A = "Z"
> -   A_append_foo = "X"
> +   A:append_foo = "X"
>  

s/A:append_foo/A:append:foo/

>  For this case, before
>  overrides are handled, ``A`` is set to "Z" and ``A_append_foo`` is set
> @@ -648,8 +648,8 @@ back as in the first example::
>  
>     OVERRIDES = "foo"
>     A = "Y"
> -   A_foo_append = "Z"
> -   A_foo_append = "X"
> +   A_foo:append = "Z"
> +   A_foo:append = "X"

(twice)
s/A_foo:append/A:foo:append/

>  
>  For this case, before any overrides are resolved,
>  ``A`` is set to "Y" using an immediate assignment. After this immediate
> @@ -661,8 +661,8 @@ leaving the variable set to "ZX". Finally, applying the override for
>  This final example mixes in some varying operators::
>  
>     A = "1"
> -   A_append = "2"
> -   A_append = "3"
> +   A:append = "2"
> +   A:append = "3"
>     A += "4"
>     A .= "5"
>  
> @@ -919,7 +919,7 @@ As an example, consider the following::
>         fn
>     }
>  
> -   fn_prepend() {
> +   fn:prepend() {
>         bbplain second
>     }
>  
> @@ -927,7 +927,7 @@ As an example, consider the following::
>         bbplain third
>     }
>  
> -   do_foo_append() {
> +   do_foo:append() {
>         bbplain fourth
>     }
>  
> @@ -977,7 +977,7 @@ override-style operators to BitBake-style Python functions.
>  
>  As an example, consider the following::
>  
> -   python do_foo_prepend() {
> +   python do_foo:prepend() {
>         bb.plain("first")
>     }
>  
> @@ -985,7 +985,7 @@ As an example, consider the following::
>         bb.plain("second")
>     }
>  
> -   python do_foo_append() {
> +   python do_foo:append() {
>         bb.plain("third")
>     }
>  
> @@ -1139,7 +1139,7 @@ before anonymous functions run. In the following example, ``FOO`` ends
>  up with the value "foo from anonymous"::
>  
>     FOO = "foo"
> -   FOO_append = " from outside"
> +   FOO:append = " from outside"
>  
>     python () {
>         d.setVar("FOO", "foo from anonymous")
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 797e2a00cc..6283c2654c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1118,7 +1118,7 @@ overview of their function and contents.
>        attempt before any others by adding something like the following to
>        your configuration::
>  
> -         PREMIRRORS_prepend = "\
> +         PREMIRRORS:prepend = "\
>           git://.*/.* https://urldefense.proofpoint.com/v2/url?u=http-3A__www.yoctoproject.org_sources_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3rKsf74xytksTpeIDY38SreNfv_q7CH9lMzWrDyrDww&s=0Xmf3ZFDICOxHg5sSg9Yyah6SmQ98MqFziI7C9y5Ut4&e=  \n \
>           https://urldefense.proofpoint.com/v2/url?u=ftp-3A__.-2A_.-2A&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3rKsf74xytksTpeIDY38SreNfv_q7CH9lMzWrDyrDww&s=50pkHuxtmu2aYHIsnUDCDKjuyK-dIlYAiLn0UQ0zGQo&e=  https://urldefense.proofpoint.com/v2/url?u=http-3A__www.yoctoproject.org_sources_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3rKsf74xytksTpeIDY38SreNfv_q7CH9lMzWrDyrDww&s=0Xmf3ZFDICOxHg5sSg9Yyah6SmQ98MqFziI7C9y5Ut4&e=  \n \
>           https://urldefense.proofpoint.com/v2/url?u=http-3A__.-2A_.-2A&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3rKsf74xytksTpeIDY38SreNfv_q7CH9lMzWrDyrDww&s=JGR-zjI5yaKOOxKRmm9r6WQFVVUB7F1tAxNdtLvsAgg&e=  https://urldefense.proofpoint.com/v2/url?u=http-3A__www.yoctoproject.org_sources_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3rKsf74xytksTpeIDY38SreNfv_q7CH9lMzWrDyrDww&s=0Xmf3ZFDICOxHg5sSg9Yyah6SmQ98MqFziI7C9y5Ut4&e=  \n \
> @@ -1184,7 +1184,7 @@ overview of their function and contents.
>        that depends on the ``perl`` package. In this case, you would use the
>        following :term:`RDEPENDS` statement::
>  
> -         RDEPENDS_${PN}-dev += "perl"
> +         RDEPENDS:${PN}-dev += "perl"
>  
>        In the example, the development package depends on the ``perl`` package.
>        Thus, the :term:`RDEPENDS` variable has the ``${PN}-dev`` package name as part
> @@ -1195,7 +1195,7 @@ overview of their function and contents.
>        differences from you. Here is the general syntax to specify versions
>        with the :term:`RDEPENDS` variable::
>  
> -         RDEPENDS_${PN} = "package (operator version)"
> +         RDEPENDS:${PN} = "package (operator version)"
>  
>        For ``operator``, you can specify the following::
>  
> @@ -1208,7 +1208,7 @@ overview of their function and contents.
>        For example, the following sets up a dependency on version 1.2 or
>        greater of the package ``foo``::
>  
> -         RDEPENDS_${PN} = "foo (>= 1.2)"
> +         RDEPENDS:${PN} = "foo (>= 1.2)"
>  
>        For information on build-time dependencies, see the :term:`DEPENDS`
>        variable.
> @@ -1237,7 +1237,7 @@ overview of their function and contents.
>        variable in conjunction with a package name override. Here is an
>        example::
>  
> -         RPROVIDES_${PN} = "widget-abi-2"
> +         RPROVIDES:${PN} = "widget-abi-2"
>  
>     :term:`RRECOMMENDS`
>        A list of packages that extends the usability of a package being
> @@ -1251,7 +1251,7 @@ overview of their function and contents.
>        differences from you. Here is the general syntax to specify versions
>        with the :term:`RRECOMMENDS` variable::
>  
> -         RRECOMMENDS_${PN} = "package (operator version)"
> +         RRECOMMENDS:${PN} = "package (operator version)"
>  
>        For ``operator``, you can specify the following::
>  
> @@ -1264,7 +1264,7 @@ overview of their function and contents.
>        For example, the following sets up a recommend on version
>        1.2 or greater of the package ``foo``::
>  
> -         RRECOMMENDS_${PN} = "foo (>= 1.2)"
> +         RRECOMMENDS:${PN} = "foo (>= 1.2)"
>  
>     :term:`SECTION`
>        The section in which packages should be categorized.
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 0d49e1da37..60aaf3902a 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1150,7 +1150,7 @@ def srcrev_internal_helper(ud, d, name):
>      if name != '':
>          attempts.append("SRCREV_%s" % name)

s/SRCREV_%s/SRCREV:%s/ ?

>      if pn:
> -        attempts.append("SRCREV_pn-%s" % pn)
> +        attempts.append("SRCREV:pn-%s" % pn)
>      attempts.append("SRCREV")
>  
>      for a in attempts:
> diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
> index 1d4a64b109..add1b13600 100644
> --- a/lib/bb/tests/data.py
> +++ b/lib/bb/tests/data.py
> @@ -245,35 +245,35 @@ class TestConcatOverride(unittest.TestCase):
>  
>      def test_prepend(self):
>          self.d.setVar("TEST", "${VAL}")
> -        self.d.setVar("TEST_prepend", "${FOO}:")
> +        self.d.setVar("TEST:prepend", "${FOO}:")
>          self.assertEqual(self.d.getVar("TEST"), "foo:val")
>  
>      def test_append(self):
>          self.d.setVar("TEST", "${VAL}")
> -        self.d.setVar("TEST_append", ":${BAR}")
> +        self.d.setVar("TEST:append", ":${BAR}")
>          self.assertEqual(self.d.getVar("TEST"), "val:bar")
>  
>      def test_multiple_append(self):
>          self.d.setVar("TEST", "${VAL}")
> -        self.d.setVar("TEST_prepend", "${FOO}:")
> -        self.d.setVar("TEST_append", ":val2")
> -        self.d.setVar("TEST_append", ":${BAR}")
> +        self.d.setVar("TEST:prepend", "${FOO}:")
> +        self.d.setVar("TEST:append", ":val2")
> +        self.d.setVar("TEST:append", ":${BAR}")
>          self.assertEqual(self.d.getVar("TEST"), "foo:val:val2:bar")
>  
>      def test_append_unset(self):
> -        self.d.setVar("TEST_prepend", "${FOO}:")
> -        self.d.setVar("TEST_append", ":val2")
> -        self.d.setVar("TEST_append", ":${BAR}")
> +        self.d.setVar("TEST:prepend", "${FOO}:")
> +        self.d.setVar("TEST:append", ":val2")
> +        self.d.setVar("TEST:append", ":${BAR}")
>          self.assertEqual(self.d.getVar("TEST"), "foo::val2:bar")
>  
>      def test_remove(self):
>          self.d.setVar("TEST", "${VAL} ${BAR}")
> -        self.d.setVar("TEST_remove", "val")
> +        self.d.setVar("TEST:remove", "val")
>          self.assertEqual(self.d.getVar("TEST"), " bar")
>  
>      def test_remove_cleared(self):
>          self.d.setVar("TEST", "${VAL} ${BAR}")
> -        self.d.setVar("TEST_remove", "val")
> +        self.d.setVar("TEST:remove", "val")
>          self.d.setVar("TEST", "${VAL} ${BAR}")
>          self.assertEqual(self.d.getVar("TEST"), "val bar")
>  
> @@ -281,42 +281,42 @@ class TestConcatOverride(unittest.TestCase):
>      # (including that whitespace is preserved)
>      def test_remove_inactive_override(self):
>          self.d.setVar("TEST", "${VAL} ${BAR}    123")
> -        self.d.setVar("TEST_remove_inactiveoverride", "val")
> +        self.d.setVar("TEST:remove_inactiveoverride", "val")
>          self.assertEqual(self.d.getVar("TEST"), "val bar    123")
>  
>      def test_doubleref_remove(self):
>          self.d.setVar("TEST", "${VAL} ${BAR}")
> -        self.d.setVar("TEST_remove", "val")
> +        self.d.setVar("TEST:remove", "val")
>          self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
>          self.assertEqual(self.d.getVar("TEST_TEST"), " bar  bar")
>  
>      def test_empty_remove(self):
>          self.d.setVar("TEST", "")
> -        self.d.setVar("TEST_remove", "val")
> +        self.d.setVar("TEST:remove", "val")
>          self.assertEqual(self.d.getVar("TEST"), "")
>  
>      def test_remove_expansion(self):
>          self.d.setVar("BAR", "Z")
>          self.d.setVar("TEST", "${BAR}/X Y")
> -        self.d.setVar("TEST_remove", "${BAR}/X")
> +        self.d.setVar("TEST:remove", "${BAR}/X")
>          self.assertEqual(self.d.getVar("TEST"), " Y")
>  
>      def test_remove_expansion_items(self):
>          self.d.setVar("TEST", "A B C D")
>          self.d.setVar("BAR", "B D")
> -        self.d.setVar("TEST_remove", "${BAR}")
> +        self.d.setVar("TEST:remove", "${BAR}")
>          self.assertEqual(self.d.getVar("TEST"), "A  C ")
>  
>      def test_remove_preserve_whitespace(self):
>          # When the removal isn't active, the original value should be preserved
>          self.d.setVar("TEST", " A B")
> -        self.d.setVar("TEST_remove", "C")
> +        self.d.setVar("TEST:remove", "C")
>          self.assertEqual(self.d.getVar("TEST"), " A B")
>  
>      def test_remove_preserve_whitespace2(self):
>          # When the removal is active preserve the whitespace
>          self.d.setVar("TEST", " A B")
> -        self.d.setVar("TEST_remove", "B")
> +        self.d.setVar("TEST:remove", "B")
>          self.assertEqual(self.d.getVar("TEST"), " A ")
>  
>  class TestOverrides(unittest.TestCase):
> @@ -362,10 +362,10 @@ class TestOverrides(unittest.TestCase):
>          self.assertEqual(self.d.getVar("TEST"), "testvalue3")
>  
>      def test_rename_override(self):
> -        self.d.setVar("ALTERNATIVE_ncurses-tools_class-target", "a")
> +        self.d.setVar("ALTERNATIVE:ncurses-tools:class-target", "a")
>          self.d.setVar("OVERRIDES", "class-target")
> -        self.d.renameVar("ALTERNATIVE_ncurses-tools", "ALTERNATIVE_lib32-ncurses-tools")
> -        self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools"), "a")
> +        self.d.renameVar("ALTERNATIVE:ncurses-tools", "ALTERNATIVE:lib32-ncurses-tools")
> +        self.assertEqual(self.d.getVar("ALTERNATIVE:lib32-ncurses-tools"), "a")
>  
>      def test_underscore_override(self):
>          self.d.setVar("TEST_bar", "testvalue2")
> @@ -377,22 +377,22 @@ class TestOverrides(unittest.TestCase):
>      def test_remove_with_override(self):
>          self.d.setVar("TEST_bar", "testvalue2")

s/TEST_bar/TEST:bar/ ?

>          self.d.setVar("TEST_some_val", "testvalue3 testvalue5")

s/TEST_some_val/TEST:some_val/ ?

> -        self.d.setVar("TEST_some_val_remove", "testvalue3")
> +        self.d.setVar("TEST_some_val:remove", "testvalue3")

s/TEST_some_val:remove/TEST:some_val:remove/ ?

>          self.d.setVar("TEST_foo", "testvalue4")

s/TEST_foo/TEST:foo/ ?

>          self.d.setVar("OVERRIDES", "foo:bar:some_val")
>          self.assertEqual(self.d.getVar("TEST"), " testvalue5")
>  
>      def test_append_and_override_1(self):
> -        self.d.setVar("TEST_append", "testvalue2")
> +        self.d.setVar("TEST:append", "testvalue2")
>          self.d.setVar("TEST_bar", "testvalue3")

s/TEST_bar/TEST:bar/ ?

>          self.assertEqual(self.d.getVar("TEST"), "testvalue3testvalue2")
>  
>      def test_append_and_override_2(self):
> -        self.d.setVar("TEST_append_bar", "testvalue2")
> +        self.d.setVar("TEST:append_bar", "testvalue2")

s/TEST:append_bar/TEST:append:bar/ ?

>          self.assertEqual(self.d.getVar("TEST"), "testvaluetestvalue2")
>  
>      def test_append_and_override_3(self):
> -        self.d.setVar("TEST_bar_append", "testvalue2")
> +        self.d.setVar("TEST_bar:append", "testvalue2")

s/TEST_bar:append/TEST:bar:append/ ?

>          self.assertEqual(self.d.getVar("TEST"), "testvalue2")
>  
>      # Test an override with _<numeric> in it based on a real world OE issue
> @@ -400,7 +400,7 @@ class TestOverrides(unittest.TestCase):
>          self.d.setVar("TARGET_ARCH", "x86_64")
>          self.d.setVar("PN", "test-${TARGET_ARCH}")
>          self.d.setVar("VERSION", "1")
> -        self.d.setVar("VERSION_pn-test-${TARGET_ARCH}", "2")
> +        self.d.setVar("VERSION:pn-test-${TARGET_ARCH}", "2")
>          self.d.setVar("OVERRIDES", "pn-${PN}")
>          bb.data.expandKeys(self.d)
>          self.assertEqual(self.d.getVar("VERSION"), "2")
> @@ -498,7 +498,7 @@ class TaskHash(unittest.TestCase):
>          d.setVar("VAR", "val")
>          # Adding an inactive removal shouldn't change the hash
>          d.setVar("BAR", "notbar")
> -        d.setVar("MYCOMMAND_remove", "${BAR}")
> +        d.setVar("MYCOMMAND:remove", "${BAR}")
>          nexthash = gettask_bashhash("mytask", d)
>          self.assertEqual(orighash, nexthash)
>  
> diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> index 9e21e18425..02a5c4952a 100644
> --- a/lib/bb/tests/parse.py
> +++ b/lib/bb/tests/parse.py
> @@ -98,8 +98,8 @@ exportD = "d"
>  
>  
>      overridetest = """
> -RRECOMMENDS_${PN} = "a"
> -RRECOMMENDS_${PN}_libc = "b"
> +RRECOMMENDS:${PN} = "a"
> +RRECOMMENDS:${PN}_libc = "b"

s/RRECOMMENDS:${PN}_libc/RRECOMMENDS:${PN}:libc/ ?

>  OVERRIDES = "libc:${PN}"
>  PN = "gtk+"
>  """
> @@ -110,13 +110,13 @@ PN = "gtk+"
>          self.assertEqual(d.getVar("RRECOMMENDS"), "b")
>          bb.data.expandKeys(d)
>          self.assertEqual(d.getVar("RRECOMMENDS"), "b")
> -        d.setVar("RRECOMMENDS_gtk+", "c")
> +        d.setVar("RRECOMMENDS:gtk+", "c")
>          self.assertEqual(d.getVar("RRECOMMENDS"), "c")
>  
>      overridetest2 = """
>  EXTRA_OECONF = ""
> -EXTRA_OECONF_class-target = "b"
> -EXTRA_OECONF_append = " c"
> +EXTRA_OECONF:class-target = "b"
> +EXTRA_OECONF:append = " c"
>  """
>  
>      def test_parse_overrides(self):
> @@ -128,7 +128,7 @@ EXTRA_OECONF_append = " c"
>  
>      overridetest3 = """
>  DESCRIPTION = "A"
> -DESCRIPTION_${PN}-dev = "${DESCRIPTION} B"
> +DESCRIPTION:${PN}-dev = "${DESCRIPTION} B"
>  PN = "bc"
>  """
>  
> @@ -136,9 +136,9 @@ PN = "bc"
>          f = self.parsehelper(self.overridetest3)
>          d = bb.parse.handle(f.name, self.d)['']
>          bb.data.expandKeys(d)
> -        self.assertEqual(d.getVar("DESCRIPTION_bc-dev"), "A B")
> +        self.assertEqual(d.getVar("DESCRIPTION:bc-dev"), "A B")
>          d.setVar("DESCRIPTION", "E")
> -        d.setVar("DESCRIPTION_bc-dev", "C D")
> +        d.setVar("DESCRIPTION:bc-dev", "C D")
>          d.setVar("OVERRIDES", "bc-dev")
>          self.assertEqual(d.getVar("DESCRIPTION"), "C D")
>  
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index 7f7e922ade..4c94b407d7 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -1719,7 +1719,7 @@ class CustomImageRecipe(Recipe):
>          """Generate the contents for the recipe file."""
>          # If we have no excluded packages we only need to _append
>          if self.excludes_set.count() == 0:
> -            packages_conf = "IMAGE_INSTALL_append = \" "
> +            packages_conf = "IMAGE_INSTALL:append = \" "
>  
>              for pkg in self.appends_set.all():
>                  packages_conf += pkg.name+' '
> diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
> index 9a5e48e3bb..04ab8bcb04 100644
> --- a/lib/toaster/toastergui/views.py
> +++ b/lib/toaster/toastergui/views.py
> @@ -1708,7 +1708,7 @@ if True:
>              except ProjectVariable.DoesNotExist:
>                  pass
>              try:
> -                return_data['image_install_append'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value,
> +                return_data['image_install:append'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL:append").value,
>              except ProjectVariable.DoesNotExist:
>                  pass
>              try:
> @@ -1839,8 +1839,8 @@ if True:
>          except ProjectVariable.DoesNotExist:
>              pass
>          try:
> -            context['image_install_append'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value
> -            context['image_install_append_defined'] = "1"
> +            context['image_install:append'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL:append").value
> +            context['image_install:append_defined'] = "1"

I've never seen this one before but maybe:
s/image_install:append_defined/image_install:append:defined/ ?

Cheers,
Quentin
