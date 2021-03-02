
                            <div class="filter_info">
                            <h3 align="center">Profit and Loss for {{$month}}</h3>
                            </div>
                        <div class="col-md-6 no-padding-left">
                            <table class="table table-bordered table-striped">
                                <theader>
                                    <tr class="success">
                                        <th colspan="3" class="text-center">Revenues</th>
                                    </tr>
                                    <tr class="active">
                                        <th width="5%">SL</th>
                                        <th>Title</th>
                                        <th>Amount</th>
                                    </tr>
                                </theader>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Product Sales</td>
                                        <td>{{round($sales->total_amount,3)}}</td>
                                    </tr>
                                    <? 
                                    $i=1;
                                    $total_deposit=0;
                                     ?>
                                @foreach($deposit as $dep)
                                <? 
                                $i++;
                                $total_deposit+=$dep->total_amount;
                                ?>
                                    <tr>
                                        <td>{{$i}}</td>
                                        <td>{{$dep->sub_category_name}}</td>
                                        <td>{{round($dep->total_amount,3)}}</td>
                                    </tr>
                                @endforeach
                                </tbody>
                                <tfooter>
                                    <tr class="warning">
                                        <th colspan="2" style="text-align:right">Total Revenues : </th>
                                        <th>{{round($total_deposit+$sales->total_amount,3)}}</th>
                                    </tr>
                                </tfooter>
                            </table>
                        </div>
                        <div class="col-md-6 no_padding">
                           <table class="table table-bordered table-striped">
                                <theader>
                                    <tr class="success">
                                        <th colspan="3" class="text-center">Costs and expenses</th>
                                    </tr>
                                    <tr class="active">
                                        <th width="5%">SL</th>
                                        <th>Title</th>
                                        <th>Amount</th>
                                    </tr>
                                </theader>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Product Purchase</td>
                                        <td>{{round($sales->total_cost,3)}}</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Total Salary</td>
                                        <td>{{round($salary->total_amount,3)}}</td>
                                    </tr>
                                    <? 
                                    $j=2;
                                    $total_payment=0;
                                    ?>
                                    @foreach($payment as $pay)
                                    <? 
                                    $j++;
                                    $total_payment+=$pay->total_amount;
                                     ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>{{$pay->sub_category_name}}</td>
                                            <td>{{round($pay->total_amount,3)}}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            <tfooter>
                                    <tr class="warning">
                                        <th colspan="2" style="text-align:right">Total Costs and expenses : </th>
                                        <th>{{round($total_payment+$sales->total_cost+$salary->total_amount,3)}}</th>
                                    </tr>
                                </tfooter>
                            </table>
                           
                        </div>
                        <table class="table table-bordered">
                            <tr class="danger">
                                <th>Net Profit or Loss </th>
                                <th>{{round((($total_deposit+$sales->total_amount)-($total_payment+$sales->total_cost+$salary->total_amount)),3)}}</th>
                            </tr>
                        </table>

                            