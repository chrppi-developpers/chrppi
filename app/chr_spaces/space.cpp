/*
From line 8 to 15
fib<fib( 0LU, M )> --> fib<fib( ( N - 1 ), M1 )>, built-in<1>

(constraint) ##fib( ( +unsigned long int ), ( ?unsigned long int ) ), persistent
(rule) fib0 @ fib( 0LU, M ) <=> M %= 1 ;;
(rule) fib1 @ fib( 1LU, M ) <=> M %= 1 ;;
(rule) fib2 @ fib( N, M ) <=> ( fib( ( N - 1 ), M1 ), fib( ( N - 2 ), M2 ), M %= ( M1 + M2 ) ) ;;
(occ rule) fib0 @ [-fib( 0LU, M )#0][] --> M %= 1 ;;
(occ rule) fib1 @ [-fib( 1LU, M )#1][] --> M %= 1 ;;
(occ rule) fib2 @ [-fib( N, M )#2][] --> ( fib( ( N - 1 ), M1 ), fib( ( N - 2 ), M2 ), M %= ( M1 + M2 ) ) ;;

(constraint store) fib( ( +unsigned long int ), ( ?unsigned long int ) ), persistent
// Rule fib0, active constraint fib( 0LU, M ), occurrence 0
Begin fib_0
	remove constraint fib( 0LU, M )
	M %= 1
	goto next goal constraint
End
// Rule fib1, active constraint fib( 1LU, M ), occurrence 1
Begin fib_1
	remove constraint fib( 1LU, M )
	M %= 1
	goto next goal constraint
End
// Rule fib2, active constraint fib( N, M ), occurrence 2
Begin fib_2
	remove constraint fib( N, M )
	fib( ( N - 1 ), M1 )
	fib( ( N - 2 ), M2 )
	M %= ( M1 + M2 )
	goto next goal constraint
End
// Fail through
Begin fib_store
	Store constraint fib
Goto next goal constraint
*/
//----------------------- START INCLUDE HEADER ---------------------
/**
 * Fibonacci sequence (Naive approach)
 *
 * The Fibonacci sequence is characterized by the fact that every number
 * after the first two is the sum of the two preceding ones.
 */

//----------------------- END INCLUDE HEADER ---------------------
#include <chrpp.hh>
class FIB {
	unsigned long int next_free_constraint_id = 1;
	//(constraint store) fib( ( +unsigned long int ), ( ?unsigned long int ) ), persistent
public:
	struct fib {
		using Type = typename std::tuple< unsigned long int, chr::Logical_var_ground< unsigned long int >, chr::Logical_var< unsigned long int > >;
	};
public:
	volatile unsigned int _ref_use_count  = 0;///< Count of shared references
	volatile unsigned int _ref_weak_count = 0;///< Count of weak references + (#shared != 0)
	FIB() { }
	~FIB() {
	}
	static chr::Shared_obj<FIB> create() { return chr::make_shared<FIB>(); }
	chr::Constraint_stores_iterator<> chr_store_begin() { return chr::Constraint_stores_iterator(); }
	chr::ES_CHR do_fib(typename fib::Type c_args);
	chr::ES_CHR fib( chr::Logical_var_ground< unsigned long int > arg0, chr::Logical_var< unsigned long int > arg1) {
		assert(!chr::failed() && (_ref_use_count >= 1));
		auto c_args = std::make_tuple(next_free_constraint_id++, arg0, arg1);
		return do_fib(std::move(c_args));
	}
};
chr::ES_CHR FIB::do_fib(typename fib::Type c_args) {
	chr::Statistics::update_call_stack();
	[[maybe_unused]] fib_call:
	// ***************************************************
	// fib_0 <=> Rule fib0, active constraint fib( 0LU, M ), occurrence 1
	[[maybe_unused]] fib_0:
	{
		if (std::get<1>(c_args) != 0LU) goto fib_1;
		auto& M = std::get<2>(c_args);
		// Body
		chr::Statistics::inc_nb_rules();
		if ((M %= 1) == chr::ES_CHR::FAILURE) return chr::ES_CHR::FAILURE;
		return chr::ES_CHR::SUCCESS;
	}
	// ***************************************************
	// fib_1 <=> Rule fib1, active constraint fib( 1LU, M ), occurrence 2
	[[maybe_unused]] fib_1:
	{
		if (std::get<1>(c_args) != 1LU) goto fib_2;
		auto& M = std::get<2>(c_args);
		// Body
		chr::Statistics::inc_nb_rules();
		if ((M %= 1) == chr::ES_CHR::FAILURE) return chr::ES_CHR::FAILURE;
		return chr::ES_CHR::SUCCESS;
	}
	// ***************************************************
	// fib_2 <=> Rule fib2, active constraint fib( N, M ), occurrence 3
	[[maybe_unused]] fib_2:
	{
		auto& N = std::get<1>(c_args);
		auto& M = std::get<2>(c_args);
		// Body
		chr::Statistics::inc_nb_rules();
		typename std::tuple_element<2,typename fib::Type>::type M1;
		if (chr::ES_CHR::FAILURE == fib( ( N - 1 ), M1 )) return chr::ES_CHR::FAILURE;
		typename std::tuple_element<2,typename fib::Type>::type M2;
		if (chr::ES_CHR::FAILURE == fib( ( N - 2 ), M2 )) return chr::ES_CHR::FAILURE;
		if ((M %= ( M1 + M2 )) == chr::ES_CHR::FAILURE) return chr::ES_CHR::FAILURE;
		return chr::ES_CHR::SUCCESS;
	}
	// Store constraint
	[[maybe_unused]] fib_store:
	return chr::ES_CHR::SUCCESS;
}
//----------------------- START INCLUDE HEADER ---------------------
//----------------------- END INCLUDE HEADER ---------------------

template <typename T>
std::vector<std::string> constraints(T & pb)
{
	std::vector<std::string> constraints;
	for (auto it = pb.chr_store_begin(); !it.at_end(); ++it)
		constraints.push_back(it.to_string());
	return constraints;
}
    