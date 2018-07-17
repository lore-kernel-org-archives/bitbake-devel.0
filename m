Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
	by mail.openembedded.org (Postfix) with ESMTP id 0D53E6FFD7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MuckRzsU+niS3g1zN+dvJnV6Cgk7fGZ9TjK+Hc9bbCw=;
	b=jQj9Amf2+QrMTYRBLxNKMmlFP/7TQ1M9h96MEjmLb5HC/FH2Ncc8vu+aq8zqmwFwd7B+vLchqFanGvp0FJHJCdZvtfFeeIw42JEg51ov7KuY7q15+aikkKk1nf7KZMbz+g2NhIiNf1N9ZNU+IIgCfrL2Q8e+ur5d8KoQ6otlIKo=
Received: from talon (85.4.236.58) by VI1PR03MB3838.eurprd03.prod.outlook.com
	(2603:10a6:803:68::22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20;
	Tue, 17 Jul 2018 11:15:55 +0000
Message-ID: <1531826153.2962.36.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Jul 2018 13:15:53 +0200
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [85.4.236.58]
X-ClientProxiedBy: VI1PR0401CA0015.eurprd04.prod.outlook.com
	(2603:10a6:800:4a::25) To VI1PR03MB3838.eurprd03.prod.outlook.com
	(2603:10a6:803:68::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a38f66c4-c557-4e43-46c0-08d5ebd6aa8d
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR03MB3838; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR03MB3838;
	3:AvZhaHMe1YfCyjuTMSICsXEflVymL3UkEHbnu4hVU1fEldbCDQdllhjPbDoL/Fd+vFn0KkDDg/Mze7EbJkmqfwLPp44v8Zg8U/Bf4i20HAaQJj8HsTcVZNG1ix6soh6YPn39ujkIPKUMMXrGOHN1f381qdV0ZJodU3Hm8X2rdYt6n0/wE35MQNuBvn0FKDzT2TS42/kCnAVY0lYtdxV2U0zAGDgZ26EkY57WGkBmzhQ4V3D1w9lOU/g7K/XcxiNo;
	25:eckshPBWSPuhHQTAbXmI+sFtx5WeQxSCp1V8z/Qv5Dg/2UvAOhjp6fo75NrSH++gGcZclzvdqRemfTRYeZW3A8em18nPYVFtcePp6yaO1Go7F06EFsLXOphcyHtFuNLgeRUZatNZGbdcUQwrsY5TFHFWMzjDZ+E8ZoP8eAeK/ibsQCeGRDn97li2NvQp+c23I4xvcSZfsHbmpE3zhcJ74eXPFnJ7vq2PpL6mKnJZAyrIiO/WLq/wApQVrHQzW470ycXEBLv92Q/g2gaHSd1y5weDF3GgYE0BEqZJ+4DUCHEYpbOdGbgTTnIcLwN8sj9nrVheHD6Fc/FqoTuMESwcXQ==;
	31:viMC8zKOQYted30y6PWakcJgNrm1TCE0rwmrP6plRh9X5lXJaNjWUa49Tg7XLu2tE6sha/ZTr8T1wAKu+TpJL5uLpPnwZQtG2wiq7s073lldnWWcJU8gkc/x06krF43B4ihiKnPHt8UrljswKpTVREVKZk03B5tBGSAp0WvoI5GNlnZliQTLWopdKDUxa41ilKCUq5tkImixbk7HasrnM4tI5e08/kHQCPFhs+T9r3A=
X-MS-TrafficTypeDiagnostic: VI1PR03MB3838:
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
X-Microsoft-Antispam-PRVS: <VI1PR03MB3838165EDFFBE022D217FA9E8F5C0@VI1PR03MB3838.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:VI1PR03MB3838; BCL:0; PCL:0; RULEID:; SRVR:VI1PR03MB3838; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR03MB3838;
	4:4z1dugZVgGv0shh4ztPwUJiGJ2glrLtnYZ5TcdlFrRSXtviNXdpRNbvxJeAhccR78lbrc3clT+BPcgNrbsxEWwSXztINzYBKUvbVBaNHRGtxkroCoZ2fl79jvDU4KpN3BiqwvkDVBA+JMLDI73akQMO7g7L4lBd8XTKmmwU/qyngkVvkmT7X2IewAKTswpFaN48K1bswxmW1ZsC5np/kynejJKzFdVXd9K+vKhnP2Y69MDt/WqBsJRkIQtFvNRRbEKJsOsq7jDWrA7aIDnFnZg==
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(39840400004)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(956004)(2361001)(14444005)(50466002)(68736007)(74482002)(103116003)(50226002)(6486002)(486006)(5660300001)(476003)(26005)(186003)(16526019)(386003)(52116002)(33896004)(6496006)(23676004)(2616005)(8676002)(81156014)(81166006)(305945005)(7736002)(5820100001)(316002)(97736004)(2351001)(105586002)(47776003)(230700001)(6916009)(8936002)(54906003)(66066001)(106356001)(25786009)(3846002)(6116002)(36756003)(478600001)(86362001)(53936002)(4326008)(2906002)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR03MB3838; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzTUIzODM4OzIzOjdYOVU5dUhuZENtUHFPNDVtQjhELzdrSTFH?=
	=?utf-8?B?NTJaV052c3ZuNnFSUzJLcHJWZE5DYkZYZHc3S2tGbTQwYldUUzVvZCtQNnRo?=
	=?utf-8?B?RGJYT29oUGd0RDM0MTlrem1mMUVUeXFoWkF6cXRjcVM5RFdla3A2cS85ZWl3?=
	=?utf-8?B?WW0yUmFDZWp0UU5YWitFYUt2MlNWRkFqZFpGQlV1cXZSYkJEVFJGYkZ1ZXRp?=
	=?utf-8?B?VUVlWlZCalFOQXNUYUNvajFnM05vSE5VZDF3Z0NUQlIrNFUzZHJQcEZvRWJz?=
	=?utf-8?B?ZjlQVzRIemx3RkxrSDBuMkpHNUNPWCtjMXE2Q2tNSlJCN3NoTEhtdVFicm0r?=
	=?utf-8?B?NmVhM1p0Ynh2VlNidVBpYmVsWG1MM2xTcXMvR3JNajUydzNORGd6aVlUZEsr?=
	=?utf-8?B?NHM3dkp1Z0FmMUJNWWxBVFI5cHExbjJCYjdKejZXQ1lJaDdLUEp5OEk2TFBJ?=
	=?utf-8?B?ZEhETHloTnI5dldmMWdneEtxMWJQMXlsZ1ovbDdhdk5lcTduQnRDQkdKbGxJ?=
	=?utf-8?B?STgwSzlsQ3F0cHcrZGdNc3Zia3hQOHpPYnlnUGFQMXdXQnkwL3JOcFA5TWNu?=
	=?utf-8?B?VDFXcTJhZy9tODVSLzlmYU1pNlpjUk5HTUtCR1A2bm9PZTVnUXRnTkFGV2hQ?=
	=?utf-8?B?ejFLdHlUZm9JekNnM0JHb2hDb2N2NVpNaHZ2WTVqM0xKeXpCWnVKTXNHalMr?=
	=?utf-8?B?RUJCNmtuU3R1OEMxb0c5cWlxKzhFT2NGZzBoYUxMUGYxUU9hczJtdnhXTmpL?=
	=?utf-8?B?aENmbmdIZmhPNFBremJRdk9YbWpUVlRBQ3g1elBhMXpoNHBpS2ZrczNVb0Q0?=
	=?utf-8?B?ZXpnckFleUdLaXFIRUtBZzlXZ2VkQkxrZmN5MUFDd1o4RjBTSlZnM1Z1ekRY?=
	=?utf-8?B?L0xKcFViVmFoTytFMklSbkNLNDBVTmcxK2VnL3orcnJKeEh0ZUZvallJVEpo?=
	=?utf-8?B?WE9PbTJpVnZHUjFENEJKYVpoWU5pcGQ2WkQxWW9ORlJoQjUwN21nejl3VndF?=
	=?utf-8?B?YUhiT3hQa0lySnRkVjVsMS9vV25WVGhjY2tYeWtVMFRWTmtmdFBTYlpzN1Jk?=
	=?utf-8?B?Z0gwODZrZkhPZHYzbVI3WTJCVS9UZnpCbjdOSitrb1ZXMUJzeTQvYXZlZTU0?=
	=?utf-8?B?ZXB4NXFIODJLYWk0ampMcS9seWt2ZEJyMFJUUXFURE1zZ0pTTGhzTFhhZGx3?=
	=?utf-8?B?Qm8xMzExSW9DR0pwZitDNndOL0RST3FiTkhnWkZvZ3NuNmNBQUFSR2k4UTda?=
	=?utf-8?B?V0pYWjIvMGhORXpLcDBoL1VQYmhrYlpVaEFLTFp6V1p6ZUdvYTJESGhSMElF?=
	=?utf-8?B?TmtxK2dROHlpV0lUZkdiQ3A3NzA0Z0M5SkF0VXZDWWlwekVIMXBHb0RaYXo0?=
	=?utf-8?B?SzFVNElPb2lUMHJuSlBJdDQ0ZzhBV1E4V01DNFN6ZVVtVVJqcWlURk1MSUlR?=
	=?utf-8?B?MzNCS281MHhEd3o4bzNrL1BlUXRpQU9zMWF2UGpxTVFtNWRqT2dsMUx2cnRk?=
	=?utf-8?B?VitTZDNhWHdpOUhxdzI2TlpyOEZJR3hldzdEdkxYakJGZ0VtYkdHOU9oSFY1?=
	=?utf-8?B?QjB2clVnWG5zRUhVeGJQZVZDUjJtSVYyTGZvU250aC9oTk5mb0ZtZTRFeUJF?=
	=?utf-8?B?MjFOQmlla0ZlS0w0cnZTaExOVVhCbFVZYytZUFo2bStLT3Q0UjRBaGpOZm13?=
	=?utf-8?Q?z+ymhfkNizF4SbBb1A=3D?=
X-Microsoft-Antispam-Message-Info: HEoAkhoAFNHKESn4/SlYatqCs9elrO70BRZWM++lJJI750sB3g7/iJfjmMQaanFuTWwBcHR3RthlR7famZvGL/E9Lu0RHHr/Z9nnwi+lXLDjatP1f4NClxR9EkDSgKBnG7P2r9nYv9SvCo49h3Pr9JFznPufup+/FL/BVZbcg84BBj01EErwWCls1k80kFuUGjb9LClDkMWwIFENbaIuiOVuVOPHxm0OloM0QRqOmPlghDjlyDAON1Lzf+YiknYzpMrUp7Y1FQi3ZrkyHFW1PTOjRJx06zdPkhIUJQP59XfSj6k2y5HaYXYAfP51WulfJaFbRFN0L6LrZ9ILNemf/YXLT2+9ZugqgWnvL2Xihn8=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR03MB3838;
	6:cUTEgb1YyRCx8r730KIwIr0vQnVoC72PzCwYMNlrt1ct0UndB2NgRCcYxUGZpHLcTAxOV8VGKiaGljzI0wmFyQUIt+wEjGvPfwBAYL0WT6yCEAQZGbyqBqXCINm3dM+CAaYLeZZWEAbgE5p2OXcV0S56U6mGbyEpRx/pZKQp7HWvODgQJzMlfYz40g/7mJBah8rLwm+SQW/WE4lupxsKO3oJFw+LrKtj9cweZ9leQ19W18wg0v6BDd39wePqX8UVIUi7pGsttF3+vgYxk8NE+I2MH5uPdLWyRw9kpd0oBUYzn1Aihxllh3Lt7bYcoXsruS73F9jtsPWZ7EspQs879M8aeukdA5aS2q0WQtrDGN+aQ6Zh7KJSY6u7pQmfV8p9me67GaQnYPesW33qmfjedrI6uH59nxslW6L8pNeJJckdRiUllqKuPdiIbkCqV1NnTipDbGB9gQ+yRU6lJn53Kw==;
	5:WgQACR6N5rAWCJDPfMudXdRe2hta8tsSIQUDR8FG90lFwLfyRCtAO0nDKXIyQxE4B/aUXPZ4pa1by9kRnSdcu/qYvK5FZL15Ukiqj57AWdwNmjNnXjeXlK0hUKW5JqRtI5LqL7U8wLbNzX/sw0h8aJrVkAxGxxPj/x88vpb6RTc=;
	24:RPuJAxL4lr99RfwILwXKxpuV4XuQDIaBV+HOMVFjApw9nGk6bjECSsm22Nszq8nLCemhCP2/qMhmgZN/yNF/AaeEllGX1oVy7LzdBHa3k8E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; VI1PR03MB3838;
	7:eXMllfx1le+HtaRbjIJRuAY0H3roNdis9tjCrthQMePF4vq3fQ6uNtV8jiB22wgVmHJqIGg2M/ZjjsdNKIHtciTRKxTmHzjE2su/WeY9mdlU+ibin+7kj9DeF7775qGxjAn2SNCM0Ne54s4lYtI5dWjAnJulP9DNVA9aW40LrNKIMgQd36GycW8pIv85F/vucwKDP5iSUmRRJaiwflNhzNJI0t7mn7v0P5vTYufKv7WZyXh7u//LlOovA9TwUjbQ
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 11:15:55.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f66c4-c557-4e43-46c0-08d5ebd6aa8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3838
Subject: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Tue, 17 Jul 2018 21:50:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,
I investigated the issue that the unpack step fails when using mirror
rewrite rules.

The root of the problem is, that the download step uses the
mirrored url to create the local filename while the unpack step uses
the url from the recipe to create the local filename.

As I understand the code, the link between the filename from
download and the filename from unpack is missing. It seems to work
because they are usually the same.

I tried both solutions proposed by Richard: Using symlinks and the
recipe-url.
The symlink solution is nice since it follows the same methods as for
git clones. Unfortunately, it is not practical for us. We like to store
the tarballs on a SMB share or S3 storage. Both do not support
symlinks.
The recipe-url naming method is nice since the tarball is named after
the url as it is written in the recipe. This is easy understandable.
But unfortunately this method breaks the test
"FetcherNetworkTest.test_gitfetch_premirror", which tests the
following: when 2 different recipe-urls point to the same mirrored-url, 
the repository is cloned only once.

Now the question is which solution we should implement. For us, it is
the second one (tarball naming after recipe-url). It comes with the
downside that the one mentioned test fails and has to be removed. In a
real scenario this results in downloading a repository twice and having
2 tarballs with the same content. But I expect this to be unlikely in a
real world scenario.

A third solution may be that we add a link between the download and
unpack task. But this would be the most intrusive solution for Bitbake.

Thanks,
Urs


